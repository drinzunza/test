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
        private val observationNameRepository: ObservationNameRepository,
        private val etagRepository: EtagRepository,
        private val userRepository: UserRepository
) {
    private val logger = LoggerFactory.getLogger(DictionaryService::class.java)

    fun getAll(etagHash: String, buildType: BuildType, companyId: Long): DictionaryDto {
        val etag = etagRepository.findFirstByHashAndCompanyId(etagHash, companyId)
        val etags = if (etag != null) etagRepository.findAllSinceEtagIdWithCompanyId(etag.id, companyId) else listOf()

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
                conditionIds?.addAll(change.conditions)
                defectIds?.addAll(change.defects)
                subcomponentIds?.addAll(change.subcomponents)
                componentIds?.addAll(change.components)
                structureIds?.addAll(change.structures)
                locationIds?.addAll(change.locationIds)
                observationNameIds?.addAll(change.observationNames)
            }
        }
        
        
        val allStructureIds = structureRepository.findAllByCompanyId(companyId).map { s -> s.id }
        val allComponentsIds = structureComponentRepository.findAllByStructureIdIn(allStructureIds).map { c -> c.componentId }
        val allSubComponentsIds = subcomponentRepository.findAllByComponentIdIn(allComponentsIds).map { s -> s.id }
        val allDefectsIds = subcomponentDefectRepository.findAllBySubcomponentIdIn(allSubComponentsIds).map { d -> d.defectId }
        val allConditionIds = conditionRepository.findAllByDefectIdIn(allDefectsIds).map { c -> c.id }
        
        val allLocations = locationIdRepository.findAll()
        val allLocationIds = mutableListOf<String>()
        for(location in allLocations){
            
            val subComponentIdList: List<String> = location?.subComponentIds?.
            split(",")?.map { it.trim() } ?: listOf<String>()

            val componentIdList: List<String> = location?.majorIds?.
            split(",")?.map { it.trim() } ?: listOf<String>()

            if(allSubComponentsIds.containsAll(subComponentIdList) && allComponentsIds.containsAll(componentIdList)){
                allLocationIds.add(location.id)
            }
        }

        val structures = getStructuresByIds(buildType, structureIds, companyId)
        val components = getComponentsByIds(buildType, componentIds, allComponentsIds)
        val subcomponents = getSubcomponentsByIds(buildType, subcomponentIds, allSubComponentsIds)
        val defects = getDefectsByIds(buildType, defectIds, allDefectsIds)
        val conditions = getConditionsByIds(buildType, conditionIds, allConditionIds)
        val locations = getLocationByIds(buildType, locationIds, allLocationIds)
        val observationNames = getObservationNameByIds(buildType, observationNameIds)

        return DictionaryDto(conditions, defects, subcomponents, components, structures, locations, observationNames)
    }

    fun getLastEtagHash(companyId: Int): String {
        return etagRepository.findTopByCompanyIdOrderByIdDesc(companyId.toLong())!!.hash
    }

    fun getObservationNameByIds(buildType: BuildType, ids: List<String>?): List<ObservationName> {
        return if (ids != null)
            observationNameRepository.findAllByIdIn(ids)
        else
            observationNameRepository.findAll().toList()
    }

    fun getLocationByIds(buildType: BuildType, ids: List<String>?, locationIds: List<String>): List<LocationIdDto> {
        val idPart = buildType.toLocationIdPart()
        return if (ids != null)
            if (idPart != null)
                locationIdRepository.findAllByIdInAndIdContains(ids, idPart).map { s -> s.toDto() }
            else
                locationIdRepository.findAllByIdIn(ids).map { s -> s.toDto() }
        else
            if (idPart != null)
                locationIdRepository.findAllByIdInAndIdContains(locationIds, idPart).map { s -> s.toDto() }
            else
                locationIdRepository.findAllByIdIn(locationIds).map { s -> s.toDto() }
    }

    fun getConditionsByIds(buildType: BuildType, ids: List<String>?, conditionIds: List<String>): List<Condition> {
        val idPart = buildType.toIdPart()
        return if (ids != null)
            if (idPart != null)
                conditionRepository.findAllByIdInAndIdContains(ids, idPart).toList()
            else
                conditionRepository.findAllByIdIn(ids).toList()
        else
            if (idPart != null)
                conditionRepository.findAllByIdInAndIdContains(conditionIds, idPart).toList()
            else
                conditionRepository.findAllByIdIn(conditionIds).toList()
    }

    fun getDefectsByIds(buildType: BuildType, ids: List<String>?, defectIds: List<String>): List<DefectDto> {
        val idPart = buildType.toIdPart()
        return if (ids != null)
            if (idPart != null)
                defectRepository.findAllByIdInAndIdContains(ids, idPart).map { s -> s.toDto() }
            else
                defectRepository.findAllByIdIn(ids).map { s -> s.toDto() }
        else
            if (idPart != null)
                defectRepository.findAllByIdInAndIdContains(defectIds, idPart).map { s -> s.toDto() }
            else
                defectRepository.findAllByIdIn(defectIds).map { s -> s.toDto() }
    }

    fun getSubcomponentsByIds(buildType: BuildType, ids: List<String>?, subComponentIds: List<String>): List<SubcomponentDto> {
        val idPart = buildType.toIdPart()
        return if (ids != null)
            if (idPart != null)
                subcomponentRepository.findAllByIdInAndIdContains(ids, idPart).map { s -> s.toDto() }
            else
                subcomponentRepository.findAllByIdIn(ids).map { s -> s.toDto() }
        else
            if (idPart != null)
                subcomponentRepository.findAllByIdInAndIdContains(subComponentIds, idPart).map { s -> s.toDto() }
            else
                subcomponentRepository.findAllByIdIn(subComponentIds).map { s -> s.toDto() }
    }

    fun getComponentsByIds(buildType: BuildType, ids: List<String>?, componentIds: List<String>): List<ComponentDto> {
        val idPart = buildType.toIdPart()
        return if (ids != null)
            if (idPart != null)
                componentRepository.findAllByIdInAndIdContains(ids, idPart).map { s -> s.toDto() }
            else
                componentRepository.findAllByIdIn(ids).map { s -> s.toDto() }
        else
            if (idPart != null)
                componentRepository.findAllByIdInAndIdContains(componentIds, idPart).map { s -> s.toDto() }
            else
                componentRepository.findAllByIdIn(componentIds).map { s -> s.toDto() }
    }

    fun getStructuresByIds(buildType: BuildType, ids: List<String>?, companyId: Long): List<StructureDto> {
        val idPart = buildType.toStructureTypePart()
        return if (ids != null)
            if (idPart != null)
                structureRepository.findAllByIdInAndTypeContains(ids, idPart).map { s -> s.toDto() }
            else
                structureRepository.findAllByIdIn(ids).map { s -> s.toDto() }
        else
            if (idPart != null)
                structureRepository.findAllByCompanyIdAndTypeContains(companyId, idPart).map { s -> s.toDto() }
            else
                structureRepository.findAllByCompanyId(companyId).map { s -> s.toDto() }
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
}