package com.uav_recon.app.api.services

import com.uav_recon.app.api.entities.db.*
import com.uav_recon.app.api.entities.requests.bridge.*
import com.uav_recon.app.api.repositories.*
import org.springframework.stereotype.Service

@Service
class DictionaryService(
        private val componentRepository: ComponentRepository,
        private val conditionRepository: ConditionRepository,
        private val defectRepository: DefectRepository,
        private val subcomponentRepository: SubcomponentRepository,
        private val structureComponentRepository: StructureComponentRepository,
        private val structureRepository: StructureRepository,
        private val subcomponentDefectRepository: SubcomponentDefectRepository
) {

    fun getAll(userId: Int): DictionaryDto {
        return DictionaryDto(
                conditionRepository.findAll().toList(),
                defectRepository.findAll().map { d -> d.toDto() },
                subcomponentRepository.findAll().map { s -> s.toDto() },
                componentRepository.findAll().map { d -> d.toDto() },
                structureRepository.findAll().map { s -> s.toDto() }
        )
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