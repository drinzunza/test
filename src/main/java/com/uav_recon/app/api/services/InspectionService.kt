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
        val projectRepository: ProjectRepository,
        val companyRepository: CompanyRepository,
        val structureRepository: StructureRepository
) : BaseService() {

    private val logger = LoggerFactory.getLogger(ObservationDefectService::class.java)

    fun Inspection.toDto(user: User?) = InspectionDto(
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
        projectId = projectId,
        inspectors = user?.let { getUsers(it, uuid) }
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
        projectId = projectId,
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
        return saved.toDto(user)
    }

    fun listNotDeletedDto(user: User, projectId: Long?, structureId: String?): List<InspectionDto> {
        return listNotDeleted(user, projectId, structureId).map { i -> i.toDto(user) }
    }

    fun listNotDeleted(user: User, projectId: Long?, structureId: String?): List<Inspection> {
        val companyProjects = user.companyId?.let { projectRepository.findAllByDeletedIsFalseAndCompanyId(it) } ?: listOf()
        val inspectionRoles = inspectionRoleRepository.findAllByUserId(user.id)
        val projectRoles = projectRoleRepository.findAllByProjectIdIn(companyProjects.map { it.id })

        val projectInspections = inspectionRepository.findAllByDeletedIsFalseAndProjectIdIn(companyProjects.map { it.id })
        val userInspections = inspectionRepository.findAllByDeletedIsFalseAndCreatedBy(user.id.toInt())
        val inspectorsInspections = inspectionRepository.findAllByDeletedIsFalseAndUuidIn(inspectionRoles.map { it.inspectionId })
        val isOwnerCompany = companyRepository.findFirstByDeletedIsFalseAndId(user.companyId ?: 0)?.type == CompanyType.OWNER

        var results = createInspections(projectInspections, userInspections, inspectorsInspections)
        if (isOwnerCompany) {
            // 1. Returns all inspections that are conducted on all his structures if he’s an owner company user
            val structures = structureRepository.findAllByCompanyId(user.companyId ?: 0)
            results = inspectionRepository.findAllByDeletedIsFalseAndStructureIdIn(structures.map { it.id })
            logger.info("Owner company user")
        } else if (user.admin) {
            // 2. Admin can see all own company inspections
        } else {
            // 3. Users can see own created inspections
            // 4. Inspectors can see assigned inspections
            // 5. PMs can see inspections of assigned projects
            results = results
                    .filter { it.canSeeInspection(user, inspectionRoles, projectRoles)}
        }
        results = results
                .filter { it.canSeeProject(projectId) }
                .filter { it.canSeeStructure(structureId) }
        logger.info("User ${user.id} can see ${results.size} inspections")
        return results
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
            return Optional.of(optional.get().toDto(null))
        }
        return Optional.empty()
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

    fun getUserIds(user: User, inspectionId: String): InspectionUsersDto {
        val users = getUsers(user, inspectionId)
        return InspectionUsersDto(inspectionId = inspectionId, inspectors = users.map { it.id })
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

    fun Inspection.canSeeProject(id: Long?): Boolean {
        return !(id != null && projectId != id)
    }

    fun Inspection.canSeeStructure(id: String?): Boolean {
        return !(id != null && structureId != id)
    }

    fun Inspection.canSeeInspection(user: User,
                         inspectionRoles: List<InspectionRole>,
                         projectRoles: List<ProjectRole>
    ): Boolean {
        val isInspector = hasInspectionRole(user, inspectionRoles, Role.INSPECTOR)
        val isPm = hasProjectRole(user, projectRoles, Role.PM)
        val isCreated = createdBy.toLong() == user.id
        val canSee = isInspector || isPm || isCreated
        if (canSee) {
            logger.info("Can see $uuid isInspector=$isInspector, isPm=$isPm, isCreated=$isCreated")
        }
        return canSee
    }

    fun hasWriteRights(user: User, inspectionId: String, projectId: Long?): Boolean {
        val inspection = getInspection(inspectionId)
        val project = getProject(inspection?.projectId ?: projectId)
        val roles = getProjectRoles(user, inspection)
        val isPM = inspection?.hasProjectRole(user, roles, Role.PM) ?: false
        val isAdmin = user.admin && user.companyId != null && user.companyId == project?.companyId
        val isCreated = inspection?.createdBy?.toLong() == user.id
        logger.info("User ${user.id} (admin=${user.admin}) company admin=$isAdmin, PM=$isPM, isCreated=$isCreated")
        return isAdmin || isPM || isCreated
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

    fun createInspections(vararg lists: List<Inspection>): List<Inspection> {
        val results = mutableListOf<Inspection>()
        for (inspections in lists) {
            inspections.forEach { inspection ->
                if (results.none { it.uuid == inspection.uuid }) {
                    results.add(inspection)
                }
            }
        }
        return results
    }
}
