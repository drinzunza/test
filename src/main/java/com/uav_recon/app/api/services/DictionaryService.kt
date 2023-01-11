package com.uav_recon.app.api.services

import com.fasterxml.jackson.databind.ObjectMapper
import com.uav_recon.app.api.controllers.handlers.AccessDeniedException
import com.uav_recon.app.api.entities.db.*
import com.uav_recon.app.api.entities.requests.bridge.*
import com.uav_recon.app.api.entities.responses.bridge.ComponentWithSubcomponentDto
import com.uav_recon.app.api.entities.responses.bridge.DefectSaveDto
import com.uav_recon.app.api.entities.responses.bridge.SubcomponentWithDefectsDto
import com.uav_recon.app.api.repositories.*
import org.slf4j.LoggerFactory
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional
import java.util.*

@Service
class DictionaryService(
        private val componentRepository: ComponentRepository,
        private val conditionRepository: ConditionRepository,
        private val defectRepository: DefectRepository,
        private val subcomponentRepository: SubcomponentRepository,
        private val structureComponentRepository: StructureComponentRepository,
        private val structureRepository: StructureRepository,
        private val subcomponentDefectRepository: SubcomponentDefectRepository,
        private val locationIdRepository: LocationIdRepository,
        private val observationNameRepository: ObservationNameRepository,
        private val etagRepository: EtagRepository,
        private val inspectionService: InspectionService,
        private val structureComponentService: StructureComponentService,
        private val structureTypeRepository: StructureTypeRepository,
        private val companyStructureTypeRepository: CompanyStructureTypeRepository,
        private val companyRepository: CompanyRepository,
        private val cannedDescriptionRepository: CannedDescriptionRepository,
        private val fileService: FileService
) {
    private val logger = LoggerFactory.getLogger(DictionaryService::class.java)

    fun getDictionaries(user: User): DictionariesDto {
        // Show user company components, subcomponents, defects
        val companyId = user.companyId ?: 0
        val companyStructureTypes = companyStructureTypeRepository.findAllByCompanyId(companyId)
        val components = componentRepository.findAllByDeletedIsFalseAndCompanyId(companyId)
                .filter { companyStructureTypes.map { it.structureTypeId }.contains(it.structureTypeId) }
        val subcomponents = subcomponentRepository.findAllByDeletedIsFalseAndComponentIdIn(components.map { it.id })
        val subcomponentDefects = subcomponentDefectRepository.findAllBySubcomponentIdIn(subcomponents.map { it.id })
        val defects = defectRepository.findAllByDeletedIsFalseAndIdIn(subcomponentDefects.map { it.defectId }.toHashSet().toList())
        val structureTypes = structureTypeRepository.findAll().toList()

        return DictionariesDto(components.filter { it.companyId == companyId }
                .map { c -> c.toDtoWithSubcomponents(subcomponents, defects, subcomponentDefects, structureTypes) }
                .filter { it.deleted == null || it.deleted == false })
    }

    fun deleteNotUnique() = subcomponentDefectRepository.deleteNotUnique()

    @Transactional
    fun saveDictionaries(user: User, body: DictionariesDto) {
        // Save user company components, subcomponents, defects
        if (!user.admin) throw AccessDeniedException()

        val companyId = user.companyId ?: 0
        val companyStructureTypes = companyStructureTypeRepository.findAllByCompanyId(companyId)
        val components = componentRepository.findAllByDeletedIsFalseAndCompanyId(companyId)
                .filter { companyStructureTypes.map { it.structureTypeId }.contains(it.structureTypeId) }
        val subcomponents = subcomponentRepository.findAllByDeletedIsFalseAndComponentIdIn(components.map { it.id })
        val subcomponentDefects = subcomponentDefectRepository.findAllBySubcomponentIdIn(subcomponents.map { it.id })
        val defects = defectRepository.findAllByDeletedIsFalseAndIdIn(subcomponentDefects.map { it.defectId })
        val structureTypes = structureTypeRepository.findAll().toList()

        val saveComponents = mutableListOf<Component>()
        val saveSubcomponents = mutableListOf<Subcomponent>()
        val saveDefects = mutableListOf<Defect>()
        val saveSubcomponentDefects = mutableListOf<SubcomponentDefect>()
        val saveConditions = mutableListOf<Condition>()

        body.components?.forEach { component ->
            if (component.id == null || components.any { it.id == component.id }) {
                val componentDto = component.toDto(user, structureTypes)
                saveComponents.add(componentDto)

                component.subcomponents?.forEach { subcomponent ->
                    val existsSubcomponent = subcomponents.firstOrNull { it.id == subcomponent.id }
                    if (subcomponent.id == null || existsSubcomponent != null) {
                        val subcomponentDto = subcomponent.toDto(componentDto.id)
                        subcomponentDto.number = subcomponent.number ?: existsSubcomponent?.number
                        subcomponentDto.description = subcomponent.description ?: existsSubcomponent?.description
                        subcomponentDto.fdotBhiValue = subcomponent.fdotBhiValue ?: existsSubcomponent?.fdotBhiValue
                        subcomponentDto.groupName = subcomponent.groupName ?: existsSubcomponent?.groupName
                        subcomponentDto.measureUnit = subcomponent.measureUnit ?: existsSubcomponent?.measureUnit
                        saveSubcomponents.add(subcomponentDto)

                        subcomponent.defects?.forEach { defect ->
                            if (defect.id == null || defects.any { it.id == defect.id }) {
                                val defectDto = defect.toDto()
                                saveDefects.add(defectDto)
                                saveSubcomponentDefects.add(SubcomponentDefect(0, subcomponentDto.id, defectDto.id))
                                if (defect.id == null) {
                                    saveConditions.add(Condition(UUID.randomUUID().toString(), "None", ConditionType.GOOD, defectDto.id, false))
                                    saveConditions.add(Condition(UUID.randomUUID().toString(), "None", ConditionType.FAIR, defectDto.id, false))
                                    saveConditions.add(Condition(UUID.randomUUID().toString(), "None", ConditionType.POOR, defectDto.id, false))
                                    saveConditions.add(Condition(UUID.randomUUID().toString(), "None", ConditionType.SEVERE, defectDto.id, false))
                                }
                            }
                        }
                    }
                }
            }
        }

        val userStructureComponents = structureComponentRepository.findAllByComponentIdIn(saveComponents.map { it.id })
        val userStructures = structureRepository.findAllByDeletedIsFalseAndIdIn(userStructureComponents.map { it.structureId })

        componentRepository.saveAll(saveComponents)
        subcomponentRepository.saveAll(saveSubcomponents)
        defectRepository.saveAll(saveDefects)
        subcomponentDefectRepository.saveAll(saveSubcomponentDefects)
        structureComponentService.refreshStructureComponents(user.companyId!!)
        conditionRepository.saveAll(saveConditions)
        etagRepository.save(getEtag(
                structures = userStructures,
                components = saveComponents,
                subcomponents = saveSubcomponents,
                defects = saveDefects,
                conditions = saveConditions
        ))
    }

    fun getEtag(structures: List<Structure>? = null,
                components: List<Component>? = null,
                subcomponents: List<Subcomponent>? = null,
                defects: List<Defect>? = null,
                conditions: List<Condition>? = null,
                locationIds: List<LocationId>? = null,
                observationNames: List<ObservationName>? = null
    ): Etag {
        val change = EtagChange()
        structures?.forEach { change.structures.add(it.id) }
        components?.forEach { change.components.add(it.id) }
        subcomponents?.forEach { change.subcomponents.add(it.id) }
        defects?.forEach { change.defects.add(it.id) }
        conditions?.forEach { change.conditions.add(it.id) }
        locationIds?.forEach { change.locationIds.add(it.id) }
        observationNames?.forEach { change.observationNames.add(it.id) }
        return Etag(
                id = 0,
                hash = UUID.randomUUID().toString(),
                change = ObjectMapper().writeValueAsString(change)
        )
    }

    fun initIds(etags: List<Etag>) = if (etags.isNotEmpty()) mutableListOf<String>() else null

    fun getEtagChanges(user: User, etagHash: String, buildType: BuildType, clientStructureIds: List<String>): DictionaryDto {
        val etag = etagRepository.findFirstByHash(etagHash)
        val etags = if (etag != null) etagRepository.findAllSinceEtagId(etag.id) else listOf()
        val allUserDictionaries = getAllUserDictionaries(user, buildType, clientStructureIds)
        return filterUserDictionaries(allUserDictionaries, etags, clientStructureIds)
    }

    fun filterUserDictionaries(dic: DictionaryDto, etags: List<Etag>, clientStructureIds: List<String>): DictionaryDto {
        val conditionIds = initIds(etags)
        val defectIds = initIds(etags)
        val subcomponentIds = initIds(etags)
        val componentIds = initIds(etags)
        val structureIds = initIds(etags)
        val locationIds = initIds(etags)
        val observationNameIds = initIds(etags)
        val companiesIds = initIds(etags)

        etags.forEach {
            val change = try {
                ObjectMapper().readValue(it.change, EtagChange::class.java)
            } catch (e: Exception) {
                logger.error("Incorrect etag change json: ${e.message}")
                null
            }
            if (change != null) {
                change.conditions.forEach { if (conditionIds?.contains(it) == false) conditionIds.add(it) }
                change.defects.forEach { if (defectIds?.contains(it) == false) defectIds.add(it) }
                change.subcomponents.forEach { if (subcomponentIds?.contains(it) == false) subcomponentIds.add(it) }
                change.components.forEach { if (componentIds?.contains(it) == false) componentIds.add(it) }
                change.structures.forEach { if (structureIds?.contains(it) == false) structureIds.add(it) }
                change.locationIds.forEach { if (locationIds?.contains(it) == false) locationIds.add(it) }
                change.observationNames.forEach { if (observationNameIds?.contains(it) == false) observationNameIds.add(it) }
                change.companies.forEach { if (companiesIds?.contains(it) == false) companiesIds.add(it) }
            }
        }

        if (etags.isNotEmpty() || clientStructureIds.isNotEmpty()) {
            val newStructureIds = mutableListOf<String>()
            dic.structures.map { it.id }.forEach {
                if (!clientStructureIds.contains(it)) newStructureIds.add(it)
            }

            val clientComponentsIds = dic.structures.filter { it.id in clientStructureIds }
                    .flatMap { it.structuralComponentIds }
                    .distinct()

            val newComponentsIds = dic.structures.filter { it.id in newStructureIds }
                        .flatMap { it.structuralComponentIds }
                        .distinct()
            val addComponentsIds = newComponentsIds - clientComponentsIds

            val addSubComponentsIds = dic.structuralComponents.filter { it.id in addComponentsIds }
                    .flatMap { it.subComponentIds }
                    .distinct()

            val addDefectsIds = dic.subComponents.filter { it.id in addSubComponentsIds }
                    .flatMap { it.defectIds }
                    .distinct()

            val addConditionIds = dic.defects.filter { it.id in addDefectsIds }
                    .flatMap { it.conditionIds }
                    .distinct()

            dic.structures = dic.structures.filter { (structureIds?.contains(it.id) ?: false) || it.id in newStructureIds }
            dic.structuralComponents = dic.structuralComponents.filter { componentIds?.contains(it.id) ?: false || it.id in addComponentsIds }
            dic.subComponents = dic.subComponents.filter { subcomponentIds?.contains(it.id) ?: false || it.id in addSubComponentsIds }
            dic.defects = dic.defects.filter { defectIds?.contains(it.id) ?: false || it.id in addDefectsIds }
            dic.conditions = dic.conditions.filter { conditionIds?.contains(it.id) ?: false  || it.id in addConditionIds}
            dic.locationIds = dic.locationIds.filter { locationIds?.contains(it.id) ?: false }
            dic.observationNames = dic.observationNames.filter { observationNameIds?.contains(it.id) ?: false }
        }

        //checkDictionaryDto(dic)
        logger.info("structures=${dic.structures.size}, components=${dic.structuralComponents.size}, " +
                "subcomponents=${dic.subComponents.size}, defects=${dic.defects.size}, " +
                "conditions=${dic.conditions.size}, locations=${dic.locationIds.size}, " +
                "observationNames=${dic.observationNames.size}, structureTypes=${dic.structureTypes.size}")
        return dic
    }

    fun getAllUserDictionaries(user: User, buildType: BuildType, clientStructureIds: List<String>): DictionaryDto {
        // Get inspections
        val inspections = inspectionService.listNotDeleted(user, null, null, null)
        val mergedStructureIds = inspections.mapNotNull { it.structureId }.toHashSet().toMutableList()
        clientStructureIds.forEach { if (!mergedStructureIds.contains(it)) mergedStructureIds.add(it) }

        // Show user company components, subcomponents, defects
        val userStructures = structureRepository.findAllByDeletedIsFalseAndIdIn(mergedStructureIds)
        var userStructureComponents = structureComponentRepository.findAllByStructureIdIn(mergedStructureIds)
        val userComponents = componentRepository.findAllByDeletedIsFalseAndIdIn(userStructureComponents.map { it.componentId })
        val userSubcomponents = subcomponentRepository.findAllByDeletedIsFalseAndComponentIdIn(userComponents.map { it.id })
        var userSubcomponentDefects = subcomponentDefectRepository.findAllBySubcomponentIdIn(userSubcomponents.map { it.id })
        val userDefects = defectRepository.findAllByDeletedIsFalseAndIdIn(userSubcomponentDefects.map { it.defectId })
        val userConditions = conditionRepository.findAllByDeletedIsFalseAndDefectIdIn(userDefects.map { it.id })
        userStructureComponents = userStructureComponents
                .filter { userComponents.map { it.id }.contains(it.componentId) }
        userSubcomponentDefects = userSubcomponentDefects
                .filter { userDefects.map { it.id }.contains(it.defectId) }
        val companyStructureTypes = user.companyId?.let { companyStructureTypeRepository.findAllByCompanyId(it) } ?: listOf()
        val userCannedDescriptions = cannedDescriptionRepository.findAllByComponentIdInAndSubcomponentIdInAndDefectIdIn(
            componentIds = userComponents.map { it.id },
            subcomponentIds = userSubcomponents.map { it.id },
            defectIds = userDefects.map { it.id }
        )

        // Get all values
        val locations = locationIdRepository.findAll().map { s -> s.toDto() }
        val observationNames = observationNameRepository.findAll().toList()
        val structureTypes = structureTypeRepository.findAll().toList()
        val observationTypes = ObservationType.values().map { ObservationTypeDto(it.title, it.name, it.letter) }
        val conditionTypes = ConditionType.values().map { ConditionTypeDto(it.title, it.name, it.csWeight) }
        val criticalFindings =
            CriticalFinding.values().map { CriticalFindingDto(it.name.toLowerCase().capitalize(), it.name, it.finding) }
        val companies: List<Company> =
            if (user.companyId != null)
                companyRepository.findAllByDeletedIsFalseAndIdIn(listOf(user.companyId!!))
            else
                listOf()
        companies.forEach { it.logo = it.logo?.let { originalLogo -> fileService.generateSignedLink(originalLogo) } }
        val structureTypeId = buildType.toStructureTypePart()
        val structures = userStructures
            .filter { structureTypeId == null || it.structureTypeId == structureTypeId }
                .filter { companyStructureTypes.map { it.structureTypeId }.contains(it.structureTypeId) }
                .map { s -> s.toDto(userStructureComponents, structureTypes) }
        val components = userComponents
                .filter { structureTypeId == null || it.structureTypeId == structureTypeId }
                .filter { companyStructureTypes.map { it.structureTypeId }.contains(it.structureTypeId) }
                .map { c -> c.toDto(userSubcomponents, structureTypes) }
        val subcomponents = userSubcomponents
                .filter { components.map { it.id }.contains(it.componentId) }
                .map { s -> s.toDto(userSubcomponentDefects, observationNames) }
        val subcomponentDefects = userSubcomponentDefects
                .filter { subcomponents.map { it.id }.contains(it.subcomponentId) }
        val defects = userDefects
                .filter { subcomponentDefects.map { it.defectId }.contains(it.id) }
                .map { d -> d.toDto(userConditions) }
        val conditions = userConditions
                .filter { defects.map { it.id }.contains(it.defectId) }
        val cannedDescriptions = userCannedDescriptions
            .filter { cannedDescription -> components.map { it.id }.contains(cannedDescription.componentId) }
            .filter { cannedDescription -> subcomponents.map { it.id }.contains(cannedDescription.subcomponentId) }
            .filter { cannedDescription -> defects.map { it.id }.contains(cannedDescription.defectId) }
            .map { it.toDto() }

        return DictionaryDto(
            conditions,
            defects,
            subcomponents,
            components,
            structures,
            locations,
            observationNames,
            structureTypes.map { t -> t.toDto() },
            observationTypes,
            conditionTypes,
            criticalFindings,
            companies,
            cannedDescriptions
        )
    }

    fun getLastEtagHash(): String {
        return etagRepository.findTopByOrderByIdDesc()!!.hash
    }

    fun checkDictionaryDto(dic: DictionaryDto) {
        logger.error("Start check dictionary relations")
        dic.structures.forEach { s ->
            s.structuralComponentIds.forEach {
                if (!dic.structuralComponents.map { it.id }.contains(it)) {
                    logger.error("Cannot find structure ${s.id} component $it")
                }
            }
        }
        dic.structuralComponents.forEach { c ->
            c.subComponentIds.forEach {
                if (!dic.subComponents.map { it.id }.contains(it)) {
                    logger.error("Cannot find structuralComponent ${c.id} subcomponent $it")
                }
            }
        }
        dic.subComponents.forEach { s ->
            s.defectIds.forEach {
                if (!dic.defects.map { it.id }.contains(it)) {
                    logger.error("Cannot find subComponent ${s.id} defect $it")
                }
            }
        }
        dic.defects.forEach { d ->
            d.conditionIds.forEach {
                if (!dic.conditions.map { it.id }.contains(it)) {
                    logger.error("Cannot find defect ${d.id} condition $it")
                }
            }
        }
        logger.error("Stop check dictionary relations")
    }

    private fun Component.toDtoWithSubcomponents(
            subcomponents: List<Subcomponent>, defects: List<Defect>, subcomponentDefects: List<SubcomponentDefect>, types: List<StructureType>
    ) = ComponentWithSubcomponentDto(
            id = id,
            name = name,
            type = types.find { it.id == structureTypeId }?.code,
            deleted = deleted,
            subcomponents = subcomponents.filter { it.componentId == id }.map { s -> s.toDtoWithDefects(defects, subcomponentDefects) }
    )

    private fun Subcomponent.toDtoWithDefects(defects: List<Defect>, subcomponentDefects: List<SubcomponentDefect>) = SubcomponentWithDefectsDto(
            id = id,
            name = name,
            deleted = deleted,
            number = number,
            description = description,
            fdotBhiValue = fdotBhiValue,
            measureUnit = measureUnit,
            groupName = groupName,
            defects = defects.filter { d -> subcomponentDefects.filter { it.subcomponentId == id }
                    .map { it.defectId }.contains(d.id) }
                    .map { d -> d.toSaveDto() }
    )

    private fun Defect.toSaveDto() = DefectSaveDto(
            id = id,
            name = name,
            number = number,
            deleted = deleted
    )

    private fun ComponentWithSubcomponentDto.toDto(user: User, types: List<StructureType>) = Component(
            id = id ?: UUID.randomUUID().toString(),
            name = name,
            structureTypeId = types.find { it.code == type }?.id ?: 0,
            companyId = user.companyId,
            deleted = deleted
    )

    private fun SubcomponentWithDefectsDto.toDto(componentId: String) = Subcomponent(
            id = id ?: UUID.randomUUID().toString(),
            name = name,
            componentId = componentId,
            deleted = deleted,
            description = description,
            fdotBhiValue = fdotBhiValue,
            groupName = groupName,
            measureUnit = measureUnit,
            number = number
    )

    private fun DefectSaveDto.toDto() = Defect(
            id = id ?: UUID.randomUUID().toString(),
            name = name,
            number = number,
            deleted = deleted
    )

    private fun Defect.toDto(conditions: List<Condition>) = DefectDto(
            id = id,
            name = name,
            number = number,
            conditionIds = conditions.filter { it.defectId == id }.map { it.id },
            deleted = deleted
    )

    private fun Subcomponent.toDto(subcomponentDefects: List<SubcomponentDefect>, observationNames: List<ObservationName>) = SubcomponentDto(
            id = id,
            name = name,
            number = number,
            fdotBhiValue = fdotBhiValue,
            description = description,
            measureUnit = measureUnit,
            componentId = componentId,
            groupName = groupName,
            deleted = deleted,
            defectIds = subcomponentDefects.filter { it.subcomponentId == id }.map { it.defectId }.toHashSet().toList(),
            observationNameIds = observationNames.map { it.id }
    )

    private fun Structure.toDto(structureComponents: List<StructureComponent>, types: List<StructureType>) = StructureDto(
            id = id,
            code = code,
            name = name,
            type = types.find { it.id == structureTypeId }?.code ?: "",
            primaryOwner = primaryOwner,
            caltransBridgeNo = caltransBridgeNo,
            postmile = postmile,
            beginStationing = beginStationing,
            endStationing = endStationing,
            deleted = deleted,
            companyId = companyId,
            structuralComponentIds = structureComponents.filter { it.structureId == id }.map { it.componentId }
    )

    private fun LocationId.toDto() = LocationIdDto(
            id = id,
            structureType = structureType,
            majorIds = majorIds?.split(','),
            subComponentIds = subComponentIds?.split(','),
            alwaysShownSpans = alwaysShownSpans?.split(','),
            iteratedSpanPatterns = iteratedSpanPatterns?.split(','),
            deleted = deleted
    )

    private fun StructureType.toDto() = StructureTypeDto(
            id = code,
            name = name,
            numOfSpansEnabled = numOfSpansEnabled,
            clockPositionEnabled = clockPositionEnabled,
            deleted = deleted,
            hideObservationType = hideObservationType,
            hideStationMarker = hideStationMarker
    )

    private fun CannedDescription.toDto() = CannedDescriptionDto(
        id = id,
        componentId = componentId,
        subcomponentId = subcomponentId,
        defectId = defectId,
        description = description
    )
}
