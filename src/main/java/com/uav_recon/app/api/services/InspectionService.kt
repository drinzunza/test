package com.uav_recon.app.api.services

import com.uav_recon.app.api.controllers.handlers.AccessDeniedException
import com.uav_recon.app.api.entities.db.*
import com.uav_recon.app.api.entities.requests.bridge.*
import com.uav_recon.app.api.entities.responses.bridge.InspectionUsersDto
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
        structureCode = structureId?.let { structureRepository.findFirstById(it) }?.code,
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
        val inspection = getInspection(dto.uuid)
        if (hasCreateDeleteRights(user, inspection, dto.projectId)) {
            // Admins and PMs can create/delete inspection
            logger.info("New inspection ${inspection?.uuid}")
        } else if (inspection != null && hasEditRights(user, inspection)) {
            // Inspectors can edit inspection
            logger.info("Exists inspection ${inspection.uuid}")
        } else {
            throw AccessDeniedException()
        }

        val updatedBy = user.id.toInt()
        var createdBy = updatedBy
        if (inspection != null) {
            createdBy = inspection.createdBy
        }
        val saved = inspectionRepository.save(dto.toEntity(null, createdBy, updatedBy))
        saveWeather(saved)
        if (dto.observations != null) {
            observationService.save(dto.observations, dto.uuid, updatedBy)
        }
        return saved.toDto(user)
    }

    fun listNotDeletedDto(user: User, projectId: Long?, structureId: String?, companyId: Long?): List<InspectionDto> {
        return listNotDeleted(user, projectId, structureId, companyId).map { i -> i.toDto(user) }
    }

    fun getCompanyIds(user: User, companyId: Long?): List<Long> {
        var companyIds = mutableListOf(user.companyId ?: 0)
        companyRepository.findAllByDeletedIsFalseAndCreatorCompanyId(user.companyId ?: 0).forEach {
            if (companyId == null) {
                companyIds.add(it.id)
            } else if (it.id == companyId) {
                companyIds = mutableListOf(companyId)
            }
        }
        return companyIds
    }

    fun getUserIds(user: User, companyIds: List<Long>): List<Int> {
        val userIds = mutableListOf(user.id.toInt())
        userRepository.findAllByCompanyIdIn(companyIds).forEach {
            userIds.add(it.id.toInt())
        }
        return userIds
    }

    fun listNotDeleted(user: User, projectId: Long?, structureId: String?, companyId: Long?): List<Inspection> {
        // Creator company user can see created companies
        val companyIds = getCompanyIds(user, companyId)
        val userIds = getUserIds(user, companyIds)

        val isOwnerCompany = companyRepository.findFirstByDeletedIsFalseAndId(companyId ?: user.companyId ?: 0)
                ?.type == CompanyType.OWNER
        val companyProjects = projectRepository.findAllByDeletedIsFalseAndCompanyIdIn(companyIds)
        val inspectionRoles = inspectionRoleRepository.findAllByUserId(user.id)
        val projectRoles = projectRoleRepository.findAllByProjectIdIn(companyProjects.map { it.id })

        var results = if (!isOwnerCompany) inspectionRepository.findAllByProjectIdInOrCreatedByInOrUuidIn(
                companyProjects.map { it.id }, userIds, inspectionRoles.map { it.inspectionId }
        ).filter { it.deleted == false } else listOf()

        if (isOwnerCompany) {
            // 1. Returns all inspections that are conducted on all his structures if he’s an owner company user
            val structures = structureRepository.findAllByDeletedIsFalseAndCompanyId(companyId ?: user.companyId ?: 0)
            results = inspectionRepository.findAllByDeletedIsFalseAndStructureIdIn(structures.map { it.id })
            logger.info("Owner company")
        } else if (user.admin) {
            // 2. Admin can see all own company inspections
            results = results
                    .filter { !(companyId != null && !companyIds.contains(companyId)) }
        } else {
            // 3. Users can see own created inspections
            // 4. Inspectors can see assigned inspections
            // 5. PMs can see inspections of assigned projects
            results = results
                    .filter { it.canSeeInspection(user, inspectionRoles, projectRoles)}
                    .filter { !(companyId != null && !companyIds.contains(companyId)) }
        }
        results = results
                .filter { it.canSeeProject(projectId) }
                .filter { it.canSeeStructure(structureId) }
        logger.info("User ${user.id} can see ${results.size} inspections")
        return results
    }

    @Throws(Error::class)
    fun delete(user: User, id: String) {
        val inspection = getInspection(id)

        // Admins and PMs can delete inspection
        if (!hasCreateDeleteRights(user, inspection, null))
            throw AccessDeniedException()

        if (inspection != null && inspection.deleted == false) {
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

    fun getUserIds(user: User, inspectionId: String): InspectionUserIdsDto {
        val users = getUsers(user, inspectionId)
        return InspectionUserIdsDto(inspectionId = inspectionId, inspectors = users.map { it.id })
    }

    @Transactional
    fun assignUsers(user: User, body: InspectionUserIdsDto): InspectionUsersDto {
        val inspection = getInspection(body.inspectionId)

        // Admins and PMs can assign users to inspection
        if (!hasCreateDeleteRights(user, inspection, null))
            throw AccessDeniedException()

        val users = userRepository.findAllByIdIn(body.inspectors)
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
        return InspectionUsersDto(body.inspectionId,
                users.map { SimpleUserDto(it.id, it.email, it.firstName, it.lastName) }
        )
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

    fun hasCreateDeleteRights(user: User, inspection: Inspection?, projectId: Long?): Boolean {
        val project = getProject(inspection?.projectId ?: projectId)
        val roles = getProjectRoles(user, inspection)
        val isPM = inspection?.hasProjectRole(user, roles, Role.PM) ?: false
        val isAdmin = user.admin && user.companyId != null && user.companyId == project?.companyId
        val isCreated = inspection?.createdBy?.toLong() == user.id
        logger.info("User ${user.id} (admin=${user.admin}) company admin=$isAdmin, PM=$isPM, isCreated=$isCreated")
        return isAdmin || isPM || isCreated
    }

    fun hasEditRights(user: User, inspection: Inspection?): Boolean {
        val roles = getInspectionRoles(user, inspection)
        val isInspector =  inspection?.hasInspectionRole(user, roles, Role.INSPECTOR) ?: false
        logger.info("User ${user.id} isInspector=$isInspector")
        return isInspector
    }

    fun getProject(projectId: Long?): Project? {
        return projectId?.let { projectRepository.findFirstById(projectId) }
    }

    fun getProjectRoles(user: User, inspection: Inspection?): List<ProjectRole> {
        return inspection?.projectId?.let {
            projectRoleRepository.findAllByProjectIdAndUserId(it, user.id)
        } ?: listOf()
    }

    fun getInspectionRoles(user: User, inspection: Inspection?): List<InspectionRole> {
        return inspection?.let {
            inspectionRoleRepository.findAllByInspectionIdAndUserId(it.uuid, user.id)
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
