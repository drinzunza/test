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
        val companyId = user.companyId ?: 0
        val components = componentRepository.findAllByCompanyId(companyId)
        val subcomponents = subcomponentRepository.findAllByComponentIdIn(components.map { it.id })
        val subcomponentDefects = subcomponentDefectRepository.findAllBySubcomponentIdIn(subcomponents.map { it.id })
        val defects = defectRepository.findAllByIdIn(subcomponentDefects.map { it.defectId })

        return DictionariesDto(components.filter { it.companyId == companyId }
                .map { c -> c.toDto(subcomponents, defects, subcomponentDefects) })
    }

    @Transactional
    fun saveDictionaries(user: User, body: DictionariesDto) {
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

    fun getEtag(
            structures: List<Structure>? = null,
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

    fun getEtagChanges(user: User, etagHash: String, buildType: BuildType, clientStructureIds: List<String>): DictionaryDto {
        val etag = etagRepository.findFirstByHash(etagHash)
        val etags = if (etag != null) etagRepository.findAllSinceEtagId(etag.id) else listOf()

        val conditionIds = if (etags.isNotEmpty()) mutableListOf<String>() else null
        val defectIds = if (etags.isNotEmpty()) mutableListOf<String>() else null
        val subcomponentIds = if (etags.isNotEmpty()) mutableListOf<String>() else null
        val componentIds = if (etags.isNotEmpty()) mutableListOf<String>() else null
        val structureIds = if (etags.isNotEmpty()) mutableListOf<String>() else null
        val locationIds = if (etags.isNotEmpty()) mutableListOf<String>() else null
        val observationNameIds = if (etags.isNotEmpty()) mutableListOf<String>() else null

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

        return filterUserDictionaries(user, buildType, clientStructureIds, conditionIds, defectIds,
                subcomponentIds, componentIds, structureIds, locationIds, observationNameIds
        )
    }

    fun filterUserDictionaries(
            user: User, buildType: BuildType, clientStructureIds: List<String>,
            conditionIds: MutableList<String>?, defectIds: MutableList<String>?,
            subcomponentIds: MutableList<String>?, componentIds: MutableList<String>?,
            structureIds: MutableList<String>?, locationIds: MutableList<String>?,
            observationNameIds: MutableList<String>?
    ): DictionaryDto {
        val inspectionRoles = inspectionRoleRepository.findAllByUserId(user.id)
        val inspections = inspectionRepository.findAllByUuidInOrCreatedByIn(inspectionRoles.map { it.inspectionId }, listOf(user.id.toInt()))
                .filter { it.deleted == false }
        val projectIds = inspections.mapNotNull { it.projectId }
        val projectStructureIds = projectStructureRepository.findAllByProjectIdIn(projectIds).map { it.structureId }
        val mergedStructureIds = mutableListOf<String>()
        clientStructureIds.forEach { mergedStructureIds.add(it) }
        structureIds?.forEach {
            if (!mergedStructureIds.contains(it) && projectStructureIds.contains(it)) {
                mergedStructureIds.add(it)
            }
        }

        val structures = getStructuresByIds(buildType, mergedStructureIds)
        val components = getComponentsByIds(buildType, componentIds)
                .filter { it.companyId == user.companyId }
        val subcomponents = getSubcomponentsByIds(buildType, subcomponentIds)
                .filter { components.map { it.id }.contains(it.componentId) }
        val subcomponentDefects = subcomponentDefectRepository.findAllBySubcomponentIdIn(subcomponents.map { it.id })
        val defects = getDefectsByIds(buildType, defectIds)
                .filter { subcomponentDefects.map { it.defectId }.contains(it.id) }

        return DictionaryDto(
                getConditionsByIds(buildType, conditionIds),
                defects,
                subcomponents,
                components,
                structures,
                getLocationByIds(buildType, locationIds),
                getObservationNameByIds(buildType, observationNameIds))
    }

    fun getLastEtagHash(): String {
        return etagRepository.findTopByOrderByIdDesc()!!.hash
    }

    fun getObservationNameByIds(buildType: BuildType, ids: List<String>?): List<ObservationName> {
        return if (ids != null)
            observationNameRepository.findAllByIdIn(ids)
        else
            observationNameRepository.findAll().toList()
    }

    fun getLocationByIds(buildType: BuildType, ids: List<String>?): List<LocationIdDto> {
        val idPart = buildType.toLocationIdPart()
        return if (ids != null)
            if (idPart != null)
                locationIdRepository.findAllByIdInAndIdContains(ids, idPart).map { s -> s.toDto() }
            else
                locationIdRepository.findAllByIdIn(ids).map { s -> s.toDto() }
        else
            if (idPart != null)
                locationIdRepository.findAllByIdContains(idPart).map { s -> s.toDto() }
            else
                locationIdRepository.findAll().map { s -> s.toDto() }
    }

    fun getConditionsByIds(buildType: BuildType, ids: List<String>?): List<Condition> {
        val idPart = buildType.toIdPart()
        return if (ids != null)
            if (idPart != null)
                conditionRepository.findAllByIdInAndIdContains(ids, idPart).toList()
            else
                conditionRepository.findAllByIdIn(ids).toList()
        else
            if (idPart != null)
                conditionRepository.findAllByIdContains(idPart).toList()
            else
                conditionRepository.findAll().toList()
    }

    fun getDefectsByIds(buildType: BuildType, ids: List<String>?): List<DefectDto> {
        val idPart = buildType.toIdPart()
        return if (ids != null)
            if (idPart != null)
                defectRepository.findAllByIdInAndIdContains(ids, idPart).map { s -> s.toDto() }
            else
                defectRepository.findAllByIdIn(ids).map { s -> s.toDto() }
        else
            if (idPart != null)
                defectRepository.findAllByIdContains(idPart).map { s -> s.toDto() }
            else
                defectRepository.findAll().map { s -> s.toDto() }
    }

    fun getSubcomponentsByIds(buildType: BuildType, ids: List<String>?): List<SubcomponentDto> {
        val idPart = buildType.toIdPart()
        return if (ids != null)
            if (idPart != null)
                subcomponentRepository.findAllByIdInAndIdContains(ids, idPart).map { s -> s.toDto() }
            else
                subcomponentRepository.findAllByIdIn(ids).map { s -> s.toDto() }
        else
            if (idPart != null)
                subcomponentRepository.findAllByIdContains(idPart).map { s -> s.toDto() }
            else
                subcomponentRepository.findAll().map { s -> s.toDto() }
    }

    fun getComponentsByIds(buildType: BuildType, ids: List<String>?): List<ComponentDto> {
        val idPart = buildType.toIdPart()
        return if (ids != null)
            if (idPart != null)
                componentRepository.findAllByIdInAndIdContains(ids, idPart).map { s -> s.toDto() }
            else
                componentRepository.findAllByIdIn(ids).map { s -> s.toDto() }
        else
            if (idPart != null)
                componentRepository.findAllByIdContains(idPart).map { s -> s.toDto() }
            else
                componentRepository.findAll().map { s -> s.toDto() }
    }

    fun getStructuresByIds(buildType: BuildType, ids: List<String>?): List<StructureDto> {
        val idPart = buildType.toStructureTypePart()
        return if (ids != null)
            if (idPart != null)
                structureRepository.findAllByIdInAndTypeContains(ids, idPart).map { s -> s.toDto() }
            else
                structureRepository.findAllByIdIn(ids).map { s -> s.toDto() }
        else
            if (idPart != null)
                structureRepository.findAllByTypeContains(idPart).map { s -> s.toDto() }
            else
                structureRepository.findAll().map { s -> s.toDto() }
    }

    private fun List<ObservationName>.toObservationNameIds(): List<String> {
        val ids = mutableListOf<String>()
        forEach { ids.add(it.id) }
        return ids
    }

    private fun List<Condition>.toConditionIds(): List<String> {
        val ids = mutableListOf<String>()
        forEach { ids.add(it.id) }
        return ids
    }

    private fun List<SubcomponentDefect>.toDefectIds(): List<String> {
        val ids = mutableListOf<String>()
        forEach { ids.add(it.defectId) }
        return ids
    }

    private fun List<StructureComponent>.toComponentIds(): List<String> {
        val ids = mutableListOf<String>()
        forEach { ids.add(it.componentId) }
        return ids
    }

    private fun List<Subcomponent>.toSubComponentIds(): List<String> {
        val ids = mutableListOf<String>()
        forEach { ids.add(it.id) }
        return ids
    }

    private fun Component.toDto(subcomponents: List<Subcomponent>, defects: List<Defect>, subcomponentDefects: List<SubcomponentDefect>) = ComponentWithSubcomponentDto(
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

    private fun Defect.toDto() = DefectDto(
            id = id,
            name = name,
            number = number,
            conditionIds = conditionRepository.findAllByDefectId(id).toConditionIds(),
            deleted = deleted
    )

    private fun Subcomponent.toDto() = SubcomponentDto(
            id = id,
            name = name,
            number = number,
            fdotBhiValue = fdotBhiValue,
            description = description,
            measureUnit = measureUnit,
            componentId = componentId,
            groupName = groupName,
            deleted = deleted,
            defectIds = subcomponentDefectRepository.findAllBySubcomponentId(id).toDefectIds(),
            observationNameIds = observationNameRepository.findAll().toList().toObservationNameIds()
    )

    private fun Structure.toDto() = StructureDto(
            id = id,
            name = name,
            type = type,
            primaryOwner = primaryOwner,
            caltransBridgeNo = caltransBridgeNo,
            postmile = postmile,
            beginStationing = beginStationing,
            endStationing = endStationing,
            deleted = deleted,
            companyId = companyId,
            structuralComponentIds = structureComponentRepository.findAllByStructureId(id).toComponentIds()
    )

    private fun Component.toDto() = ComponentDto(
            id = id,
            name = name,
            type = type,
            companyId = companyId,
            deleted = deleted,
            subComponentIds = subcomponentRepository.findAllByComponentId(id).toSubComponentIds()
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