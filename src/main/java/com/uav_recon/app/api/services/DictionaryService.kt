package com.uav_recon.app.api.services

import com.fasterxml.jackson.databind.ObjectMapper
import com.uav_recon.app.api.controllers.AuthController
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
        private val etagRepository: EtagRepository
) {
    private val logger = LoggerFactory.getLogger(DictionaryService::class.java)

    fun getAll(etagHash: String, userId: Int): DictionaryDto {
        val etag = etagRepository.findFirstByHash(etagHash)
        val etags = if (etag != null) etagRepository.findAllSinceEtagId(etag.id) else listOf()

        val conditionIds = mutableListOf<String>()
        val defectIds = mutableListOf<String>()
        val subcomponentIds = mutableListOf<String>()
        val componentIds = mutableListOf<String>()
        val structureIds = mutableListOf<String>()

        etags.forEach {
            val change = try {
                ObjectMapper().readValue(it.change, EtagChange::class.java)
            } catch (e: Exception) {
                logger.error("Incorrect etag change json: ${e.message}")
                null
            }
            if (change != null) {
                conditionIds.addAll(change.conditions)
                defectIds.addAll(change.defects)
                subcomponentIds.addAll(change.subcomponents)
                componentIds.addAll(change.components)
                structureIds.addAll(change.structures)
            }
        }

        return DictionaryDto(
                getConditionsByIds(if (etags.isNotEmpty()) conditionIds else null),
                getDefectsByIds(if (etags.isNotEmpty()) defectIds else null),
                getSubcomponentsByIds(if (etags.isNotEmpty()) subcomponentIds else null),
                getComponentsByIds(if (etags.isNotEmpty()) componentIds else null),
                getStructuresByIds(if (etags.isNotEmpty()) structureIds else null))
    }

    fun getLastEtagHash(): String {
        return etagRepository.findTopByOrderByIdDesc()!!.hash
    }

    fun getConditionsByIds(ids: List<String>?): List<Condition> {
        return if (ids != null)
            conditionRepository.findAllByIdIn(ids).toList()
        else
            conditionRepository.findAll().toList()
    }

    fun getDefectsByIds(ids: List<String>?): List<DefectDto> {
        return if (ids != null)
            defectRepository.findAllByIdIn(ids).map { s -> s.toDto() }
        else
            defectRepository.findAll().map { s -> s.toDto() }
    }

    fun getSubcomponentsByIds(ids: List<String>?): List<SubcomponentDto> {
        return if (ids != null)
            subcomponentRepository.findAllByIdIn(ids).map { s -> s.toDto() }
        else
            subcomponentRepository.findAll().map { s -> s.toDto() }
    }

    fun getComponentsByIds(ids: List<String>?): List<ComponentDto> {
        return if (ids != null)
            componentRepository.findAllByIdIn(ids).map { s -> s.toDto() }
        else
            componentRepository.findAll().map { s -> s.toDto() }
    }

    fun getStructuresByIds(ids: List<String>?): List<StructureDto> {
        return if (ids != null)
            structureRepository.findAllByIdIn(ids).map { s -> s.toDto() }
        else
            structureRepository.findAll().map { s -> s.toDto() }
    }

    private fun Defect.toDto() = DefectDto(
            id = id,
            name = name,
            number = number,
            conditionIds = conditionRepository.findAllByDefectId(id).toConditionIds(),
            isDeleted = isDeleted
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
            isDeleted = isDeleted,
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
            isDeleted = isDeleted,
            structuralComponentIds = structureComponentRepository.findAllByStructureId(id).toComponentIds()
    )

    private fun Component.toDto() = ComponentDto(
            id = id,
            name = name,
            isDeleted = isDeleted,
            subComponentIds = subcomponentRepository.findAllByComponentId(id).toStructuralComponentIds()
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

    private fun List<Subcomponent>.toStructuralComponentIds(): List<String> {
        val ids = mutableListOf<String>()
        forEach { ids.add(it.componentId) }
        return ids
    }
}