package com.uav_recon.app.api.services

import com.uav_recon.app.api.controllers.handlers.AccessDeniedException
import com.uav_recon.app.api.entities.db.*
import com.uav_recon.app.api.entities.requests.bridge.*
import com.uav_recon.app.api.entities.responses.bridge.ComponentTypesUsageDto
import com.uav_recon.app.api.entities.responses.bridge.ComponentUsageDto
import com.uav_recon.app.api.entities.responses.bridge.InspectionUsersDto
import com.uav_recon.app.api.repositories.*
import org.slf4j.LoggerFactory
import org.springframework.stereotype.Service
import org.springframework.web.multipart.MultipartFile
import java.util.*
import javax.transaction.Transactional
import kotlin.Error
import kotlin.math.roundToInt

@Service
class InspectionService(
    private val inspectionRepository: InspectionRepository,
    private val photoRepository: PhotoRepository,
    private val photoService: PhotoService,
    private val observationRepository: ObservationRepository,
    private val observationDefectRepository: ObservationDefectRepository,
    private val observationDefectService: ObservationDefectService,
    private val observationService: ObservationService,
    private val weatherService: WeatherService,
    private val userRepository: UserRepository,
    private val inspectionRoleRepository: InspectionRoleRepository,
    private val projectRoleRepository: ProjectRoleRepository,
    private val projectRepository: ProjectRepository,
    private val companyRepository: CompanyRepository,
    private val structureRepository: StructureRepository,
    private val componentRepository: ComponentRepository,
    private val subcomponentRepository: SubcomponentRepository,
    private val defectRepository: DefectRepository,
    private val conditionRepository: ConditionRepository,
    private val observationNameRepository: ObservationNameRepository,
    private val locationIdRepository: LocationIdRepository,
    private val fileService: FileService,
    private val structureSubdivisionRepository: StructureSubdivisionRepository,
    private val structureSubdivisionService: StructureSubdivisionService,
    private val observationStructureSubdivisionRepository: ObservationStructureSubdivisionRepository,
    private val observationStructureSubdivisionService: ObservationStructureSubdivisionService
) : BaseService() {

    private val logger = LoggerFactory.getLogger(ObservationDefectService::class.java)

    fun Inspection.toDto(
        withObservations: Boolean = true,
        inspectors: List<SimpleUserDto>? = null,
        structure: Structure? = null,
        observations: List<ObservationDto>? = null,
        withSignedLink: Boolean = true
    ) = InspectionDtoV2(
        uuid = uuid,
        location = if (latitude != null) LocationDto(latitude, longitude, altitude) else null,
        endDate = endDate,
        startDate = startDate,
        generalSummary = generalSummary,
        isEditable = isEditable,
        sgrRating = sgrRating,
        structureId = structureId,
        structureCode = structure?.code ?: structureId?.let { structureRepository.findFirstById(it) }?.code,
        structureName = structure?.name ?: structureId?.let { structureRepository.findFirstById(it) }?.name,
        report = if (reportId != null) InspectionReport(reportId,
            if (withSignedLink) reportLink?.let { fileService.generateSignedLink(it) } else reportLink,
            reportDate
        ) else null,
        status = status,
        termRating = termRating,
        weather = if (temperature != null) Weather(temperature, humidity, wind) else null,
        observations = observations ?: if (withObservations) observationService.findAllByInspectionUuidAndNotDeleted(
            uuid
        ) else listOf(),
        spansCount = spansCount,
        projectId = projectId,
        archived = archived,
        previousInspectionId = previousInspectionId,
        inspectors = inspectors ?: getUsers(uuid),
        structureSubdivisions = structureSubdivisionService.getAllByInspectionId(uuid)
    )

    fun Inspection.toDtoV2(
        inspectors: List<SimpleUserDto>? = null,
        structure: Structure? = null,
        observations: List<ObservationDto>? = null
    ): InspectionDtoV2 {
        return InspectionDtoV2(
            uuid = uuid,
            location = if (latitude != null) LocationDto(latitude, longitude, altitude) else null,
            endDate = endDate,
            startDate = startDate,
            generalSummary = generalSummary,
            isEditable = isEditable,
            sgrRating = sgrRating,
            structureId = structureId,
            structureCode = structure?.code ?: structureId?.let { structureRepository.findFirstById(it) }?.code,
            structureName = structure?.name ?: structureId?.let { structureRepository.findFirstById(it) }?.name,
            report = if (reportId != null) InspectionReport(reportId,
                reportLink?.let { fileService.generateSignedLink(it) }, reportDate) else null,
            status = status,
            termRating = termRating,
            weather = if (temperature != null) Weather(temperature, humidity, wind) else null,
            observations = observations ?: listOf(),
            spansCount = spansCount,
            projectId = projectId,
            archived = archived,
            previousInspectionId = previousInspectionId,
            inspectors = inspectors ?: getUsers(uuid),
            structureSubdivisions = structureSubdivisionService.getAllByInspectionId(uuid)
        )
    }

    fun saveV1(user: User, dto: InspectionDto) = save(user, dto.toDtoV2()).toDtoV1()

    @Transactional
    fun save(user: User, dto: InspectionDtoV2): InspectionDtoV2 {
        logger.info("inspection uuid = ${dto.uuid}")
        val inspection = getInspection(dto.uuid)
        if (hasCreateDeleteRights(user, inspection, dto.projectId)) {
            // Admins and PMs can create/delete inspection
            logger.info("Admin/PM inspection ${inspection?.uuid}")
        } else {
            throw AccessDeniedException()
        }

        // TODO temporary fix
        if (dto.generalSummary.isNullOrBlank() && user.companyId == 5L) {
            dto.generalSummary = "Weather:\nTemp:\nUnit 1:\nUnit 2:\nUnit 3:\nHW:\nTW:\nProject Q:"
        }

        val updatedBy = user.id.toInt()
        var createdBy = updatedBy
        if (inspection != null) {
            createdBy = inspection.createdBy
        }
        val saved = inspectionRepository.save(dto.toEntity(null, createdBy, updatedBy))
        //If this is a newly created inspection, populate empty observations based on structure template.
        if (inspection == null) {
            // Get observations based on template.
            val observations =
                observationService.generateObservationsFromTemplate(user, dto.structureId.toString(), dto.uuid)
            // Populate observation in inspection.
            observationService.save(observations, dto.uuid, updatedBy)
        }
        saveWeather(saved)
        if (dto.observations != null) {
            observationService.save(dto.observations, dto.uuid, updatedBy)
        }
        return saved.toDto()
    }

    fun cloneInspection(user: User, dto: InspectionCloneDto): InspectionDtoV2 {
        val existingInspection = getInspection(dto.existingInspectionUuid)
        if (hasCreateDeleteRights(user, existingInspection, dto.projectId)) {
            // Admins and PMs can create/delete inspection
            logger.info("Admin/PM inspection ${existingInspection?.uuid}")
        } else {
            throw AccessDeniedException()
        }

        if (existingInspection == null) {
            throw Error("Inspection does not exist")
        }
        
        // generate clone
        val userId = user.id.toInt()
        val cloneInspection = Inspection(
            uuid = dto.uuid,
            createdBy = userId,
            updatedBy = userId,
            isEditable = existingInspection.isEditable,
            startDate = dto.startDate,
            structureId = existingInspection.structureId,
            temperature = existingInspection.temperature,
            humidity = existingInspection.humidity,
            wind = existingInspection.wind,
            latitude = existingInspection.latitude,
            longitude = existingInspection.longitude,
            altitude = existingInspection.altitude,
            status = InspectionStatus.IN_PROGRESS,
            reportId = existingInspection.reportId,
            reportDate = existingInspection.reportDate,
            reportLink = existingInspection.reportLink,
            generalSummary = existingInspection.generalSummary,
            sgrRating = existingInspection.sgrRating,
            termRating = existingInspection.termRating,
            spansCount = existingInspection.spansCount,
            deleted = existingInspection.deleted,
            projectId = dto.projectId,
            archived = false,
            previousInspectionId = existingInspection.uuid
        )
        inspectionRepository.save(cloneInspection)

        // convert clone to Dto to fetch related objects
        val existingInspectionDto = existingInspection.toDto(withSignedLink = false)

        // clone the observations
        existingInspectionDto.observations?.forEach { currentObservation ->
             val cloneObservation = observationService.cloneObservation(
                sourceObservationDto = currentObservation,
                createdBy = userId,
                updatedBy = userId,
                inspectionId = dto.uuid
            )

            // clone the defects
            currentObservation.observationDefects?.forEach { currentObservationDefect ->
                val cloneObservationDefect = observationDefectService.cloneObservationDefect(
                    sourceObservationDefectDto = currentObservationDefect,
                    createdBy = userId,
                    updatedBy = userId,
                    observationId = cloneObservation.uuid,
                    createdAtClient = null
                )

                // clone the photos
                currentObservationDefect.photos?.forEach {
                    photoService.clonePhoto(
                        sourcePhotoDto = it,
                        observationDefectId = cloneObservationDefect.uuid,
                        createdBy = userId,
                        updatedBy = userId,
                        createdAtClient = null
                    )
                }
            }
        }

        // assign inspectors to cloned inspection
        val inspectionRoles = dto.inspectors?.map {
            InspectionRole(
                inspectionId = dto.uuid,
                userId = it.id,
                roles = arrayOf(Role.INSPECTOR)
            )
        }
        inspectionRoleRepository.saveAll(inspectionRoles)

        return cloneInspection.toDto()
    }

    @Throws(Error::class)
    fun getPhotosArchiveData(inspectionId: String): InspectionArchivePhotoDto {
        val inspection = inspectionRepository.findByUuidAndDeletedIsFalse(inspectionId)
        val inspectionArchivePhotoDto = InspectionArchivePhotoDto();
        logger.info(inspection.toString())
        if (inspection.isPresent && inspection.get().structureId != null) {
            val structure = structureRepository.findFirstById(inspection.get().structureId!!)
            logger.info(structure.toString())
            val observations = observationRepository.findAllByInspectionIdAndDeletedIsFalse(inspection.get().uuid);
            logger.info(observations.count().toString())
            if (structure != null) {
                val observationDefects = observationDefectRepository
                    .findAllByDeletedIsFalseAndObservationIdIn(observations.map(Observation::uuid))
                logger.info(observationDefects.count().toString())
                val photos = photoRepository
                    .findAllByDeletedIsFalseAndObservationDefectIdIn(observationDefects.map(ObservationDefect::uuid));
                logger.info(photos.count().toString())
                val groupByDefectId = photos.groupBy(Photo::observationDefectId)
                val defectIdArrayList = arrayListOf<String>()
                defectIdArrayList.ensureCapacity(photos.count());
                val resultPhotos = groupByDefectId
                    .flatMap { (groupByDefectIdKey, groupByDefectIdValue) ->
                        val defectObj = observationDefects.find { it.uuid == groupByDefectIdKey }
                        var defectId = defectObj?.id;
                        val existDefectIdCount = Collections.frequency(defectIdArrayList, defectId);
                        if (defectIdArrayList.contains(defectId)) {
                            defectId = "$defectId(${existDefectIdCount + 1})";
                        } else {
                            if (defectId != null) {
                                defectIdArrayList.add(defectId);
                            }
                        }
                        groupByDefectIdValue.mapIndexed { index, it ->
                            InspectionArchivePhotoItemDto(
                                fileService.get(it.link, it.drawables, FileService.FileType.WITH_RECT),
                                defectId,
                                index = index + 1
                            )
                        }
                    }
                logger.info(resultPhotos.count().toString())
                inspectionArchivePhotoDto.photos = resultPhotos
                inspectionArchivePhotoDto.structureCode = structure.code;
                inspectionArchivePhotoDto.structureName = structure.name;
            }
        } else {
            throw Error(105, "Inspection not found or inspection does not contain relation to structure")
        }
        return inspectionArchivePhotoDto;
    }

    @Throws(Error::class)
    fun getInspectionOpOrd(inspectionId: String): String {
        val inspection = inspectionRepository.findByUuidAndDeletedIsFalse(inspectionId)
        var link = ""
        if (inspection.isPresent) {
            val path = "op_ord_docs/$inspectionId.docx"
            try {
                link = fileService.generateSignedLink(path)
            } catch (e: Exception) {
                throw Error(105, "Operational order document not found in this inspection")
            }
        } else {
            throw Error(105, "Inspection not found")
        }
        return link
    }

    @Throws(Error::class)
    fun attachOpOrdToInspection(inspectionId: String, data: MultipartFile): String {
        val inspection = inspectionRepository.findByUuidAndDeletedIsFalse(inspectionId)
        var link = ""
        if (inspection.isPresent) {
            link = fileService.save("op_ord_docs/$inspectionId.docx", data.bytes, "docx", null)
        } else {
            throw Error(105, "Inspection not found")
        }
        return link
    }

    fun listNotDeletedDtoV1(
        user: User,
        projectId: Long?,
        structureId: String?,
        companyId: Long?,
        withObservations: Boolean
    ) = listNotDeletedDto(
        user,
        projectId,
        structureId,
        companyId,
        withObservations
    ).map { notDeletedItem -> notDeletedItem.toDtoV1() }

    fun listNotDeletedDto(
        user: User,
        projectId: Long?,
        structureId: String?,
        companyId: Long?,
        withObservations: Boolean
    ): List<InspectionDtoV2> {
        var inspections = listNotDeleted(user, projectId, structureId, companyId)

        // TODO fix for admin inspection android crash (Out Of Memory)
        var observations: Map<String, List<ObservationDto>>? = null
        if (withObservations) {
            val inspectionRoles = inspectionRoleRepository.findAllByUserId(user.id)
            val assignedInspectionIds = inspectionRoles.map { it.inspectionId }
            inspections =
                inspections.filter { it.createdBy.toLong() == user.id || assignedInspectionIds.contains(it.uuid) }
            observations = observationService.findAllByInspectionUuidsAndNotDeleted(inspections.map { it.uuid })
        }

        val inspectorsMap = getUsers(inspections.map { it.uuid })
        val structures = structureRepository.findAllByIdIn(inspections.mapNotNull { it.structureId })
        val inspectionDtos = ArrayList<InspectionDtoV2>(inspections.size)
        inspections.parallelStream().forEach { i ->
            inspectionDtos.add(
                i.toDtoV2(
                    inspectorsMap[i.uuid],
                    structures.find { it.id == i.structureId },
                    observations?.get(i.uuid)
            )
            )
        }
        return inspectionDtos;
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

    fun getNotDeletedV1(user: User, uuid: String) = getNotDeleted(user, uuid).toDtoV1()

    fun getNotDeleted(user: User, uuid: String): InspectionDtoV2 {
        val inspection = listNotDeleted(user, null, null, null)
            .firstOrNull { uuid.isNotBlank() && it.uuid == uuid }
            ?: throw Error(181, "Not found inspection")
        return inspection.toDto(true)
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
                .filter { it.canSeeInspection(user, inspectionRoles, projectRoles) }
                .filter { !(companyId != null && !companyIds.contains(companyId)) }
        }
        results = results
            .filter { it.canSeeProject(projectId) }
            .filter { it.canSeeStructure(structureId) }

        fillObjectsForSgrAndHealthIndex(results)
        val countSgr = updateSgrRating(results)
        logger.info("Saved $countSgr inspections with new sgr rating")

        logger.info("User ${user.id} can see ${results.size} inspections")
        return results
    }

    fun updateSgrRating(results: List<Inspection>): Int {
        val sgrChangedInspections = mutableListOf<Inspection>()
        results.parallelStream().forEach { inspection ->
            calculateSgrRating(inspection)?.let { sgrRating ->
                val roundedSgrRating = (sgrRating * 10).roundToInt() / 10.0
                if (inspection.sgrRating?.toDoubleOrNull() != roundedSgrRating) {
                    inspection.sgrRating = roundedSgrRating.toString()
                    sgrChangedInspections.add(inspection)
                }
            }
        }
        inspectionRepository.saveAll(sgrChangedInspections)
        return sgrChangedInspections.size
    }

    fun updateHealthIndex(results: List<Inspection>): Int {
        val healthIndexChangedObservations = mutableListOf<Observation>()
        results.forEach { inspection ->
            inspection.observations?.forEach {
                val spansCount = observationService.getSpansCount(it, inspection.spansCount) ?: 0
                var healthIndex = observationService.getHealthIndex(it, spansCount)
                healthIndex = (healthIndex * 1000).toInt().toDouble() / 1000
                if (it.healthIndex != healthIndex) {
                    it.healthIndex = healthIndex
                    healthIndexChangedObservations.add(it)
                }
            }
        }
        observationRepository.saveAll(healthIndexChangedObservations)
        return healthIndexChangedObservations.size
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
            return Optional.of(optional.get().toDto().toDtoV1())
        }
        return Optional.empty()
    }

    fun saveWeather(inspection: Inspection): Inspection {
        if (inspection.temperature == null) {
            val weather = weatherService.getHistoricalWeather(
                inspection.latitude, inspection.longitude, inspection.startDate?.toEpochSecond()
            )
            if (weather != null) {
                logger.info(
                    "Save inspection weather ${inspection.latitude}:${inspection.longitude}, " +
                            "${inspection.createdAt}, ${weather.temperature}, ${weather.humidity}, ${weather.wind}"
                )
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

    fun getUsers(inspectionId: String): List<SimpleUserDto> {
        // All can see users on inspection
        val ids = inspectionRoleRepository.findAllByInspectionId(inspectionId)
            .filter { it.roles?.contains(Role.INSPECTOR) ?: false }
            .map { it.userId }
        return userRepository.findAllByIdIn(ids).map { u -> u.toDto() }
    }

    fun getUsers(inspectionIds: List<String>): Map<String, List<SimpleUserDto>> {
        // All can see users on inspection
        val map = mutableMapOf<String, List<SimpleUserDto>>()
        val roles = inspectionRoleRepository.findAllByInspectionIdIn(inspectionIds)
            .filter { it.roles?.contains(Role.INSPECTOR) ?: false }
        val users = userRepository.findAllByIdIn(roles.map { it.userId }).map { u -> u.toDto() }
        inspectionIds.parallelStream().forEach { id ->
            map[id] = users.filter { roles.filter { it.inspectionId == id }.map { it.userId }.contains(it.id) }
        }
        return map
    }

    fun getUserIds(user: User, inspectionId: String): InspectionUserIdsDto {
        val users = getUsers(inspectionId)
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

    fun updateSummary(dto: InspectionSummaryDto): InspectionDtoV2 {
        logger.info("inspection uuid = ${dto.uuid}, summary = ${dto.summary}")
        getInspection(dto.uuid)?.let {
            it.generalSummary = dto.summary
            return inspectionRepository.save(it).toDto()
        }
        throw Error(101, "Invalid inspection UUID")
    }

    fun updateArchive(dto: InspectionArchiveDto): InspectionDtoV2 {
        logger.info("inspection uuid = ${dto.uuid}, archived = ${dto.archived}")
        getInspection(dto.uuid)?.let {
            it.archived = dto.archived
            return inspectionRepository.save(it).toDto()
        }
        throw Error(101, "Invalid inspection UUID")
    }

    fun updateInspection(user: User, uuid: String, dto: InspectionUpdateDto): InspectionDtoV2 {
        logger.info("inspection uuid = $uuid")
        getInspection(uuid)?.let {
            it.update(dto)
            return inspectionRepository.save(it).toDto(false)
        }
        throw Error(101, "Invalid inspection UUID")
    }

    fun Inspection.canSeeProject(id: Long?): Boolean {
        return !(id != null && projectId != id)
    }

    fun Inspection.canSeeStructure(id: String?): Boolean {
        return !(id != null && structureId != id)
    }

    fun Inspection.canSeeInspection(
        user: User,
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
        val roles = getProjectRoles(user, project)
        val isPM = project?.hasProjectRole(user, roles, Role.PM) ?: false

        // Hack for old user inspections with project == null
        val isCompanyProject = if (project?.companyId == null) true else user.companyId == project.companyId

        val isAdmin = user.admin && user.companyId != null && isCompanyProject
        val isCreated = inspection?.createdBy?.toLong() == user.id
        logger.info("User ${user.id}, inspection ${inspection?.uuid}, project ${project?.id}")
        logger.info("admin=${user.admin}, company admin=$isAdmin, PM=$isPM, isCreated=$isCreated")
        return isAdmin || isPM || isCreated
    }

    fun hasEditRights(user: User, inspection: Inspection?): Boolean {
        val roles = getInspectionRoles(user, inspection)
        val isInspector = inspection?.hasInspectionRole(user, roles, Role.INSPECTOR) ?: false
        logger.info("User ${user.id} isInspector=$isInspector")
        return isInspector
    }

    fun getProject(projectId: Long?): Project? {
        return projectId?.let { projectRepository.findFirstById(projectId) }
    }

    fun getProjectRoles(user: User, project: Project?): List<ProjectRole> {
        return project?.let {
            projectRoleRepository.findAllByProjectIdAndUserId(it.id, user.id)
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

    fun calculateSgrRating(inspection: Inspection): Double? {
        var numerator = 0.0
        var denominator = 0.0
        inspection.observations?.forEach {
            val number = it.subcomponent?.fdotBhiValue ?: return@forEach
            val spansCount = observationService.getSpansCount(it, inspection.spansCount) ?: 0
            val healthIndex = observationService.getHealthIndex(it, spansCount)
            if (observationService.getTotalQuantity(it, spansCount) > 0) {
                numerator += number * healthIndex
                denominator += number
            }
        }
        if (denominator == 0.0) return null
        return (numerator / denominator) * 100
    }

    fun fillObjects(inspections: List<Inspection>) {
        val observations = observationRepository.findAllByDeletedIsFalseAndInspectionIdIn(inspections.map { it.uuid })
        val components = componentRepository.findAllByIdIn(observations.map { it.structuralComponentId ?: "" })
        val subcomponents = subcomponentRepository.findAllByIdIn(observations.map { it.subComponentId ?: "" })
        val observationDefects =
            observationDefectRepository.findAllByDeletedIsFalseAndObservationIdIn(observations.map { it.uuid })
        val photos = photoRepository.findAllByDeletedIsFalseAndObservationDefectIdIn(observationDefects.map { it.uuid })
        val defects = defectRepository.findAllByIdIn(observationDefects.map { it.defectId ?: "" })
        val conditions = conditionRepository.findAllByIdIn(observationDefects.map { it.conditionId ?: "" })
        val observationNames =
            observationNameRepository.findAllByIdIn(observationDefects.map { it.observationNameId ?: "" })
        val locationIds = locationIdRepository.findAll()
        val structureSubdivisions = mutableListOf<StructureSubdivision>()
        inspections.forEach { structureSubdivisions.addAll(structureSubdivisionRepository.findAllByInspectionId(it.uuid)) }

        structureSubdivisions.forEach { structureSubdivision ->
            structureSubdivision.computedSgrRating = structureSubdivisionService.calculateSubdivisionSgr(structureSubdivision)
            structureSubdivision.observationStructureSubdivisions =
                observationStructureSubdivisionRepository.findAllByStructureSubdivisionId(structureSubdivision.uuid)
            structureSubdivision.observationStructureSubdivisions!!.forEach {
                it.computedHealthIndex = observationStructureSubdivisionService.calculateSubdivisionObservationHealthIndex(it)
            }
        }
        observationDefects.forEach { observationDefect ->
            observationDefect.defect = defects.firstOrNull { it.id == observationDefect.defectId }
            observationDefect.condition = conditions.firstOrNull { it.id == observationDefect.conditionId }
            observationDefect.observationName =
                observationNames.firstOrNull { it.id == observationDefect.observationNameId }
            observationDefect.photos = photos.filter { it.observationDefectId == observationDefect.uuid }
            observationDefect.structureSubdivision = structureSubdivisions.firstOrNull { it.uuid == observationDefect.structureSubdivisionId }
        }
        observations.forEach { observation ->
            observation.component = components.firstOrNull { it.id == observation.structuralComponentId }
            observation.subcomponent = subcomponents.firstOrNull { it.id == observation.subComponentId }
            observation.defects = observationDefects.filter { it.observationId == observation.uuid }
            observation.locationIds = locationIds.toList()
        }
        inspections.forEach { inspection ->
            inspection.observations = observations.filter { it.inspectionId == inspection.uuid }
            inspection.structureSubdivisions = structureSubdivisions.filter { it.inspectionId == inspection.uuid }
        }
    }

    fun fillObjectsForSgrAndHealthIndex(inspections: List<Inspection>) {
        val observations = observationRepository.findAllByDeletedIsFalseAndInspectionIdIn(inspections.map { it.uuid })
        val subcomponents = subcomponentRepository.findAllByIdIn(observations.map { it.subComponentId ?: "" })
        val observationDefects =
            observationDefectRepository.findAllByDeletedIsFalseAndObservationIdIn(observations.map { it.uuid })
        val conditions = conditionRepository.findAllByIdIn(observationDefects.map { it.conditionId ?: "" })
        val locationIds = locationIdRepository.findAll()

        observationDefects.parallelStream().forEach { observationDefect ->
            observationDefect.condition = conditions.firstOrNull { it.id == observationDefect.conditionId }
        }
        observations.parallelStream().forEach { observation ->
            observation.subcomponent = subcomponents.firstOrNull { it.id == observation.subComponentId }
            observation.defects = observationDefects.filter { it.observationId == observation.uuid }
            observation.locationIds = locationIds.toList()
        }
        inspections.parallelStream().forEach { inspection ->
            inspection.observations = observations.filter { it.inspectionId == inspection.uuid }
        }
    }

    fun getComponentUsage(
        user: User,
        projectId: Long?,
        structureId: String?,
        type: StructuralType?
    ): List<ComponentUsageDto> {
        val inspectionIds = listNotDeleted(user, projectId, structureId, null).map { it.uuid }
        val observations = observationRepository.findAllByDeletedIsFalseAndInspectionIdIn(inspectionIds)
        val observationIds = observations.map { it.uuid }
        val componentIds = observations.mapNotNull { it.structuralComponentId }
        val components = componentRepository.findAllByIdIn(componentIds)
        val observationDefects = observationDefectRepository.findAllByDeletedIsFalseAndObservationIdIn(observationIds)
            .filter { type == null || it.type == type }

        val componentsUsage = mutableListOf<ComponentUsageDto>()
        components.forEach { component ->
            val componentObservationIds =
                observations.filter { it.structuralComponentId == component.id }.map { it.uuid }
            val count = observationDefects.count { componentObservationIds.contains(it.observationId) }
            componentsUsage.add(ComponentUsageDto(component.id, component.name, count))
        }
        return componentsUsage
    }

    fun getComponentTypesUsage(user: User, projectId: Long?, structureId: String?): ComponentTypesUsageDto {
        val inspectionIds = listNotDeleted(user, projectId, structureId, null).map { it.uuid }
        val observations = observationRepository.findAllByDeletedIsFalseAndInspectionIdIn(inspectionIds)
        val observationIds = observations.map { it.uuid }
        val observationDefectsTypes =
            observationDefectRepository.findAllByDeletedIsFalseAndObservationIdIn(observationIds)
                .map { it.type }

        return ComponentTypesUsageDto(
            observationDefectsTypes.count { it == StructuralType.STRUCTURAL },
            observationDefectsTypes.count { it == StructuralType.MAINTENANCE }
        )
    }
}
