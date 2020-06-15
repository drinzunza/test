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
        private val projectStructureRepository: ProjectStructureRepository,
        private val inspectionRoleRepository: InspectionRoleRepository,
        private val inspectionRepository: InspectionRepository
) {
    private val logger = LoggerFactory.getLogger(DictionaryService::class.java)

    fun getDictionaries(user: User): DictionariesDto {
        // Show user company components, subcomponents, defects
        val companyId = user.companyId ?: 0
        val components = componentRepository.findAllByCompanyId(companyId)
        val subcomponents = subcomponentRepository.findAllByComponentIdIn(components.map { it.id })
        val subcomponentDefects = subcomponentDefectRepository.findAllBySubcomponentIdIn(subcomponents.map { it.id })
        val defects = defectRepository.findAllByIdIn(subcomponentDefects.map { it.defectId })

        return DictionariesDto(components.filter { it.companyId == companyId }
                .map { c -> c.toDtoWithSubcomponents(subcomponents, defects, subcomponentDefects) }
                .filter { it.deleted == null || it.deleted == false })
    }

    @Transactional
    fun saveDictionaries(user: User, body: DictionariesDto) {
        // Save user company components, subcomponents, defects
        if (!user.admin) throw AccessDeniedException()

        val companyId = user.companyId ?: 0
        val components = componentRepository.findAllByCompanyId(companyId)
        val subcomponents = subcomponentRepository.findAllByComponentIdIn(components.map { it.id })
        val subcomponentDefects = subcomponentDefectRepository.findAllBySubcomponentIdIn(subcomponents.map { it.id })
        val defects = defectRepository.findAllByIdIn(subcomponentDefects.map { it.defectId })

        val saveComponents = mutableListOf<Component>()
        val saveSubcomponents = mutableListOf<Subcomponent>()
        val saveDefects = mutableListOf<Defect>()
        val saveSubcomponentDefects = mutableListOf<SubcomponentDefect>()
        body.components?.forEach { component ->
            if (component.id == null || components.any { it.id == component.id }) {
                val componentDto = component.toDto(user)
                saveComponents.add(componentDto)

                component.subcomponents?.forEach { subcomponent ->
                    if (subcomponent.id == null || subcomponents.any { it.id == subcomponent.id }) {
                        val subcomponentDto = subcomponent.toDto(componentDto.id)
                        saveSubcomponents.add(subcomponentDto)

                        subcomponent.defects?.forEach { defect ->
                            if (defect.id == null || defects.any { it.id == defect.id }) {
                                val defectDto = defect.toDto()
                                saveDefects.add(defect.toDto())
                                saveSubcomponentDefects.add(SubcomponentDefect(0, subcomponentDto.id, defectDto.id))
                            }
                        }
                    }
                }
            }
        }

        componentRepository.saveAll(saveComponents)
        subcomponentRepository.saveAll(saveSubcomponents)
        defectRepository.saveAll(saveDefects)
        subcomponentDefectRepository.saveAll(saveSubcomponentDefects)
        etagRepository.save(getEtag(
                components = saveComponents,
                subcomponents = saveSubcomponents,
                defects = saveDefects
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

        val conditionIds = initIds(etags)
        val defectIds = initIds(etags)
        val subcomponentIds = initIds(etags)
        val componentIds = initIds(etags)
        val structureIds = initIds(etags)
        val locationIds = initIds(etags)
        val observationNameIds = initIds(etags)

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
            }
        }

        val allUserDictionaries = getAllUserDictionaries(user, buildType, clientStructureIds)
        return filterUserDictionaries(allUserDictionaries, conditionIds, defectIds,
                subcomponentIds, componentIds, structureIds, locationIds, observationNameIds
        )
    }

    fun filterUserDictionaries(allUserDictionaries: DictionaryDto,
            conditionIds: MutableList<String>?, defectIds: MutableList<String>?,
            subcomponentIds: MutableList<String>?, componentIds: MutableList<String>?,
            structureIds: MutableList<String>?, locationIds: MutableList<String>?,
            observationNameIds: MutableList<String>?
    ): DictionaryDto {
        // TODO add
        return allUserDictionaries
    }

    fun getAllUserDictionaries(user: User, buildType: BuildType, clientStructureIds: List<String>): DictionaryDto {
        // Get inspectors and PM
        val inspectionRoles = inspectionRoleRepository.findAllByUserId(user.id)
        val inspections = inspectionRepository.findAllByUuidInOrCreatedByIn(inspectionRoles.map { it.inspectionId }, listOf(user.id.toInt()))
                .filter { it.deleted == false }
        val projectIds = inspections.mapNotNull { it.projectId }.toHashSet().toList()
        val projectStructureIds = projectStructureRepository.findAllByProjectIdIn(projectIds).map { it.structureId }

        // Merge client, etag, project structures
        val mergedStructureIds = mutableListOf<String>()
        clientStructureIds.forEach { mergedStructureIds.add(it) }
        projectStructureIds.forEach { if (!mergedStructureIds.contains(it)) mergedStructureIds.add(it) }

        // Show user company components, subcomponents, defects
        val userStructureComponents = structureComponentRepository.findAllByStructureIdIn(mergedStructureIds)
        val userComponents = componentRepository.findAllByIdIn(userStructureComponents.map { it.componentId })
        val userSubcomponents = subcomponentRepository.findAllByComponentIdIn(userComponents.map { it.id })
        val userSubcomponentDefects = subcomponentDefectRepository.findAllBySubcomponentIdIn(userSubcomponents.map { it.id })
        val userDefects = defectRepository.findAllByIdIn(userSubcomponentDefects.map { it.defectId }.toHashSet().toList())
        val userConditions = conditionRepository.findAllByDefectIdIn(userDefects.map { it.id })

        // Get all values
        val locations = locationIdRepository.findAll().map { s -> s.toDto() }
        val observationNames = observationNameRepository.findAll().toList()

        // Get dictionaries with ids
        val type = buildType.toStructureTypePart()
        val structures = structureRepository.findAllByIdIn(mergedStructureIds)
                .filter { type == null || it.type == type }
                .map { s -> s.toDto(userStructureComponents) }
        val components = userComponents
                .filter { type == null || it.type == type }
                .map { c -> c.toDto(userSubcomponents) }
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

        return DictionaryDto(conditions, defects, subcomponents, components, structures, locations, observationNames)
    }

    fun getLastEtagHash(): String {
        return etagRepository.findTopByOrderByIdDesc()!!.hash
    }

    private fun Component.toDtoWithSubcomponents(subcomponents: List<Subcomponent>, defects: List<Defect>, subcomponentDefects: List<SubcomponentDefect>) = ComponentWithSubcomponentDto(
            id = id,
            name = name,
            type = type,
            deleted = deleted,
            subcomponents = subcomponents.filter { it.componentId == id }.map { s -> s.toDtoWithDefects(defects, subcomponentDefects) }
    )

    private fun Subcomponent.toDtoWithDefects(defects: List<Defect>, subcomponentDefects: List<SubcomponentDefect>) = SubcomponentWithDefectsDto(
            id = id,
            name = name,
            deleted = deleted,
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

    private fun ComponentWithSubcomponentDto.toDto(user: User) = Component(
            id = id ?: UUID.randomUUID().toString(),
            name = name,
            type = type,
            companyId = user.companyId,
            deleted = deleted
    )

    private fun SubcomponentWithDefectsDto.toDto(componentId: String) = Subcomponent(
            id = id ?: UUID.randomUUID().toString(),
            name = name,
            componentId = componentId,
            deleted = deleted
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
            defectIds = subcomponentDefects.filter { it.subcomponentId == id }.map { it.defectId },
            observationNameIds = observationNames.map { it.id }
    )

    private fun Structure.toDto(structureComponents: List<StructureComponent>) = StructureDto(
            id = id,
            code = code,
            name = name,
            type = type,
            primaryOwner = primaryOwner,
            caltransBridgeNo = caltransBridgeNo,
            postmile = postmile,
            beginStationing = beginStationing,
            endStationing = endStationing,
            deleted = deleted,
            companyId = companyId,
            structuralComponentIds = structureComponents.filter { it.structureId == id }.map { it.componentId }
    )

    private fun Component.toDto(subcomponents: List<Subcomponent>) = ComponentDto(
            id = id,
            name = name,
            type = type,
            companyId = companyId,
            deleted = deleted,
            subComponentIds = subcomponents.filter { it.componentId == id }.map { it.id }
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
}