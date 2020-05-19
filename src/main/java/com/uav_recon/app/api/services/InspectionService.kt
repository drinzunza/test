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
) {

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
        if (!hasWriteRights(user, dto.uuid))
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

    fun listNotDeleted(user: User): List<InspectionDto> {
        val projects = user.companyId?.let { projectRepository.findAllByDeletedIsFalseAndCompanyId(it) } ?: listOf()
        val inspections = inspectionRepository.findAllByDeletedIsFalseAndProjectIdIn(projects.map { it.id })

        return if (user.admin) {
            // Admin can see all own company inspections
            inspections.map { i -> i.toDto() }
        } else {
            // Inspectors can see assigned inspections & PMs can see inspections of assigned projects
            inspections.filter {
                hasInspectionRole(it.uuid, user.id, Role.INSPECTOR) || hasProjectRole(it.projectId, user.id, Role.PM)
            }.map { i -> i.toDto() }
        }
    }

    @Throws(Error::class)
    fun delete(user: User, id: String) {
        // Admins and PMs can delete inspection
        if (!hasWriteRights(user, id))
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

    fun getUsers(user: User, inspectionId: String, role: Role): List<SimpleUserDto> {
        // All can see users on inspection
        val ids = inspectionRoleRepository.findAllByInspectionId(inspectionId)
                .filter { it.roles?.contains(role) ?: false }
                .map { it.id }
        return userRepository.findAllByIdIn(ids).map { u -> u.toDto() }
    }

    @Transactional
    fun assignUsers(user: User, body: InspectionUsersDto): InspectionUsersDto {
        // Admins and PMs can assign users to inspection
        if (!hasWriteRights(user, body.inspectionId))
            throw AccessDeniedException()

        val existRoles = inspectionRoleRepository.findAllByInspectionId(body.inspectionId)
        val inspectionRoles = body.users.map {
            InspectionRole(
                    inspectionId = body.inspectionId,
                    userId = it.id,
                    roles = it.roles.toTypedArray()
            )
        }
        inspectionRoleRepository.deleteAll(existRoles)
        inspectionRoleRepository.saveAll(inspectionRoles)
        return body
    }

    fun hasWriteRights(user: User, inspectionId: String): Boolean {
        val project = inspectionRepository.findFirstByUuid(inspectionId)?.let { inspection ->
            inspection.projectId?.let {
                projectRepository.findFirstById(it)
            }
        }
        val isPM = hasProjectRole(project?.id, user.id, Role.PM)
        val isAdmin = user.admin && user.companyId == project?.companyId
        return isAdmin || isPM
    }

    fun hasProjectRole(projectId: Long?, userId: Long, role: Role): Boolean {
        if (projectId == null) return false
        return projectRoleRepository.findAllByProjectIdAndUserId(projectId, userId).any {
            it.roles?.contains(role) ?: false
        }
    }

    fun hasInspectionRole(inspectionId: String, userId: Long, role: Role): Boolean {
        return inspectionRoleRepository.findAllByInspectionIdAndUserId(inspectionId, userId).any {
            it.roles?.contains(role) ?: false
        }
    }

    fun hasAnyProjectRole(projectId: Long?, userId: Long): Boolean {
        if (projectId == null) return false
        return projectRoleRepository.findAllByProjectIdAndUserId(projectId, userId).any {
            !it.roles.isNullOrEmpty()
        }
    }

    fun hasAnyInspectionRole(inspectionId: String, userId: Long): Boolean {
        return inspectionRoleRepository.findAllByInspectionIdAndUserId(inspectionId, userId).any {
            !it.roles.isNullOrEmpty()
        }
    }
}
