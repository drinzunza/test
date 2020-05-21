package com.uav_recon.app.api.services

import com.uav_recon.app.api.controllers.handlers.AccessDeniedException
import com.uav_recon.app.api.entities.db.*
import com.uav_recon.app.api.entities.requests.bridge.*
import com.uav_recon.app.api.repositories.*
import org.slf4j.LoggerFactory
import org.springframework.stereotype.Service
import java.util.*
import javax.transaction.Transactional

@Service
class InspectionService(
        val inspectionRepository: InspectionRepository,
        val photoRepository: PhotoRepository,
        val observationRepository: ObservationRepository,
        val observationDefectRepository: ObservationDefectRepository,
        val observationService: ObservationService,
        val weatherService: WeatherService,
        val userRepository: UserRepository,
        val inspectionRoleRepository: InspectionRoleRepository,
        val projectRoleRepository: ProjectRoleRepository,
        val projectRepository: ProjectRepository
) : BaseService() {

    private val logger = LoggerFactory.getLogger(ObservationDefectService::class.java)

    fun Inspection.toDto() = InspectionDto(
        uuid = uuid,
        location = if (latitude != null) LocationDto(latitude, longitude, altitude) else null,
        endDate = endDate,
        startDate = startDate,
        generalSummary = generalSummary,
        isEditable = isEditable,
        sgrRating = sgrRating,
        structureId = structureId,
        report = if (reportId != null) InspectionReport(reportId, reportLink, reportDate) else null,
        status = status,
        termRating = termRating,
        weather = if (temperature != null) Weather(temperature, humidity, wind) else null,
        observations = observationService.findAllByInspectionUuidAndNotDeleted(uuid),
        spansCount = spansCount,
        projectId = projectId
    )

    fun InspectionDto.toEntity(weather: Weather?, createdBy: Int, updatedBy: Int) = Inspection(
        uuid = uuid,
        latitude = location?.latitude,
        longitude = location?.longitude,
        altitude = location?.altitude,
        endDate = endDate,
        startDate = startDate,
        generalSummary = generalSummary,
        sgrRating = sgrRating,
        structureId = structureId,
        status = status,
        termRating = termRating,
        spansCount = spansCount,
        temperature = weather?.temperature,
        humidity = weather?.humidity,
        wind = weather?.wind,
        createdBy = createdBy,
        updatedBy = updatedBy
    )

    fun User.toDto() = SimpleUserDto(
            id = id,
            firstName = firstName,
            lastName = lastName,
            email = email
    )

    @Transactional
    fun save(user: User, dto: InspectionDto): InspectionDto {
        // Admins and PMs can edit inspection
        if (!hasWriteRights(user, dto.uuid, dto.projectId))
            throw AccessDeniedException()

        val updatedBy = user.id.toInt()
        var createdBy = updatedBy
        val inspection = inspectionRepository.findById(dto.uuid)
        if (inspection.isPresent) {
            createdBy = inspection.get().createdBy
        }
        val saved = inspectionRepository.save(dto.toEntity(null, createdBy, updatedBy))
        saveWeather(saved)
        if (dto.observations != null) {
            observationService.save(dto.observations, dto.uuid, updatedBy)
        }
        return saved.toDto()
    }

    fun listNotDeleted(user: User, projectId: Long?, structureId: String?): List<InspectionDto> {
        val companyProjects = user.companyId?.let { projectRepository.findAllByDeletedIsFalseAndCompanyId(it) } ?: listOf()
        val inspections = inspectionRepository.findAllByDeletedIsFalseAndProjectIdIn(companyProjects.map { it.id })

        val results: List<Inspection>
        if (user.admin) {
            // Admin can see all own company inspections
            results = inspections.filter { !(projectId != null && it.projectId != projectId) }
            logger.info("User admin, inspections: ${results.map { it.uuid }}")
        } else {
            // Users can see own created inspections

            // Inspectors can see assigned inspections
            val inspectionRoles = inspectionRoleRepository.findAllByUserId(user.id)

            // PMs can see inspections of assigned projects
            val projectRoles = projectRoleRepository.findAllByProjectIdIn(companyProjects.map { it.id })

            results = inspections
                    .filter { canSeeInspection(user, it, inspectionRoles, projectRoles)}
                    .filter { !(projectId != null && it.projectId != projectId) }
        }
        return results.map { i -> i.toDto() }
    }

    @Throws(Error::class)
    fun delete(user: User, id: String) {
        // Admins and PMs can delete inspection
        if (!hasWriteRights(user, id, null))
            throw AccessDeniedException()

        val optional = inspectionRepository.findByUuidAndDeletedIsFalse(id)
        if (optional.isPresent) {
            val inspection = optional.get()
            inspection.deleted = true
            inspectionRepository.save(inspection)
        } else {
            throw Error(101, "Invalid inspection UUID")
        }
    }

    fun findById(id: String): Optional<InspectionDto> {
        val optional = inspectionRepository.findById(id)
        if (optional.isPresent) {
            return Optional.of(optional.get().toDto());
        }
        return Optional.empty();
    }

    fun getPhotoWithCoordinates(inspection: Inspection): Photo? {
        observationRepository.findAllByInspectionIdAndDeletedIsFalse(inspection.uuid).forEach { observation ->
            observationDefectRepository.findAllByObservationIdAndDeletedIsFalse(observation.uuid).forEach { observationDefect ->
                photoRepository.findAllByObservationDefectIdAndDeletedIsFalse(observationDefect.uuid).forEach {
                    if (it.latitude != null && it.longitude != null) {
                        return it
                    }
                }
            }
        }
        return null
    }

    fun saveWeather(inspection: Inspection): Inspection {
        if (inspection.temperature == null) {
            val weather = weatherService.getHistoricalWeather(
                    inspection.latitude, inspection.longitude, inspection.startDate?.toEpochSecond()
            )
            if (weather != null) {
                logger.info("Save inspection weather ${inspection.latitude}:${inspection.longitude}, " +
                        "${inspection.createdAt}, ${weather.temperature}, ${weather.humidity}, ${weather.wind}")
                inspection.temperature = weather.temperature
                inspection.humidity = weather.humidity
                inspection.wind = weather.wind
                return inspectionRepository.save(inspection)
            }
        } else {
            logger.info("Inspection weather already set")
        }
        return inspection
    }

    fun getUsers(user: User, inspectionId: String): List<SimpleUserDto> {
        // All can see users on inspection
        val ids = inspectionRoleRepository.findAllByInspectionId(inspectionId)
                .filter { it.roles?.contains(Role.INSPECTOR) ?: false }
                .map { it.userId }
        return userRepository.findAllByIdIn(ids).map { u -> u.toDto() }
    }

    @Transactional
    fun assignUsers(user: User, body: InspectionUsersDto): InspectionUsersDto {
        // Admins and PMs can assign users to inspection
        if (!hasWriteRights(user, body.inspectionId, null))
            throw AccessDeniedException()

        val existRoles = inspectionRoleRepository.findAllByInspectionId(body.inspectionId)
        val inspectionRoles = body.inspectors.map {
            InspectionRole(
                    inspectionId = body.inspectionId,
                    userId = it,
                    roles = arrayOf(Role.INSPECTOR)
            )
        }
        inspectionRoleRepository.deleteAll(existRoles)
        inspectionRoleRepository.saveAll(inspectionRoles)
        return body
    }

    fun canSeeInspection(user: User, inspection: Inspection,
                         inspectionRoles: List<InspectionRole>,
                         projectRoles: List<ProjectRole>
    ): Boolean {
        val isInspector = inspection.hasInspectionRole(user, inspectionRoles, Role.INSPECTOR)
        val isPm = inspection.hasProjectRole(user, projectRoles, Role.PM)
        val isCreated = inspection.createdBy.toLong() == user.id
        val canSee = isInspector || isPm || isCreated
        if (canSee) {
            logger.info("Can see inspection ${inspection.uuid} isInspector=$isInspector, isPm=$isPm, isCreated=$isCreated")
        }
        return canSee
    }

    fun hasWriteRights(user: User, inspectionId: String, projectId: Long?): Boolean {
        val inspection = getInspection(inspectionId)
        val project = getProject(inspection?.projectId ?: projectId)
        val roles = getProjectRoles(user, inspection)
        val isPM = inspection?.hasProjectRole(user, roles, Role.PM) ?: false
        val isAdmin = user.admin && user.companyId != null && user.companyId == project?.companyId
        logger.info("User ${user.id} company admin=$isAdmin, PM=$isPM, project company=${project?.companyId}")
        return isAdmin || isPM
    }

    fun getProject(projectId: Long?): Project? {
        return projectId?.let { projectRepository.findFirstById(projectId) }
    }

    fun getProjectRoles(user: User, inspection: Inspection?): List<ProjectRole> {
        return inspection?.projectId?.let {
            projectRoleRepository.findAllByProjectIdAndUserId(it, user.id)
        } ?: listOf()
    }

    fun getInspection(inspectionId: String): Inspection? {
        return inspectionRepository.findFirstByUuid(inspectionId)
    }
}
