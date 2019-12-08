package com.uav_recon.app.api.services

import com.fasterxml.jackson.databind.ObjectMapper
import com.uav_recon.app.api.entities.db.*
import com.uav_recon.app.api.entities.requests.bridge.*
import com.uav_recon.app.api.repositories.*
import org.slf4j.LoggerFactory
import org.springframework.stereotype.Service
import java.lang.Exception

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
        private val etagRepository: EtagRepository
) {
    private val logger = LoggerFactory.getLogger(DictionaryService::class.java)

    fun getAll(etagHash: String, buildType: BuildType): DictionaryDto {
        val etag = etagRepository.findFirstByHash(etagHash)
        val etags = if (etag != null) etagRepository.findAllSinceEtagId(etag.id) else listOf()

        val conditionIds = if (etags.isNotEmpty()) mutableListOf<String>() else null
        val defectIds = if (etags.isNotEmpty()) mutableListOf<String>() else null
        val subcomponentIds = if (etags.isNotEmpty()) mutableListOf<String>() else null
        val componentIds = if (etags.isNotEmpty()) mutableListOf<String>() else null
        val structureIds = if (etags.isNotEmpty()) mutableListOf<String>() else null
        val locationIds = if (etags.isNotEmpty()) mutableListOf<String>() else null

        etags.forEach {
            val change = try {
                ObjectMapper().readValue(it.change, EtagChange::class.java)
            } catch (e: Exception) {
                logger.error("Incorrect etag change json: ${e.message}")
                null
            }
            if (change != null) {
                conditionIds?.addAll(change.conditions)
                defectIds?.addAll(change.defects)
                subcomponentIds?.addAll(change.subcomponents)
                componentIds?.addAll(change.components)
                structureIds?.addAll(change.structures)
                locationIds?.addAll(change.locationIds)
            }
        }

        return DictionaryDto(
                getConditionsByIds(buildType, conditionIds),
                getDefectsByIds(buildType, defectIds),
                getSubcomponentsByIds(buildType, subcomponentIds),
                getComponentsByIds(buildType, componentIds),
                getStructuresByIds(buildType, structureIds),
                getLocationByIds(buildType, locationIds))
    }

    fun getLastEtagHash(): String {
        return etagRepository.findTopByOrderByIdDesc()!!.hash
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
            defectIds = subcomponentDefectRepository.findAllBySubcomponentId(id).toDefectIds()
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
            structuralComponentIds = structureComponentRepository.findAllByStructureId(id).toComponentIds()
    )

    private fun Component.toDto() = ComponentDto(
            id = id,
            name = name,
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
}