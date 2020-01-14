package com.uav_recon.app.api.services

import com.uav_recon.app.api.entities.db.*
import com.uav_recon.app.api.entities.requests.bridge.ObservationDto
import com.uav_recon.app.api.repositories.ConditionRepository
import com.uav_recon.app.api.repositories.InspectionRepository
import com.uav_recon.app.api.repositories.ObservationRepository
import org.springframework.data.repository.findByIdOrNull
import org.springframework.stereotype.Service
import javax.transaction.Transactional

@Service
class ObservationService(
        private val inspectionRepository: InspectionRepository,
        private val observationRepository: ObservationRepository,
        private val conditionRepository: ConditionRepository,
        private val observationDefectService: ObservationDefectService
) {
    private val MEASURE_TYPE_EACH = "each"
    private val invalidInspectionUuid = Error(101, "Invalid inspection UUID")

    fun Observation.toDto() = ObservationDto(
        id = id,
        uuid = uuid,
        drawingNumber = drawingNumber,
        locationDescription = locationDescription,
        roomNumber = roomNumber,
        dimensionNumber = dimensionNumber,
        structuralComponentId = structuralComponentId,
        subComponentId = subComponentId,
        observationDefects = observationDefectService.findAllByObservationIdAndNotDeleted(uuid)
    )

    fun ObservationDto.toEntity(createdBy: Int, updatedBy: Int, inspectionId: String) = Observation(
        id = id,
        uuid = uuid,
        createdBy = createdBy,
        updatedBy = updatedBy,
        subComponentId = subComponentId,
        structuralComponentId = structuralComponentId,
        dimensionNumber = dimensionNumber,
        roomNumber = roomNumber,
        locationDescription = locationDescription,
        drawingNumber = drawingNumber,
        inspectionId = inspectionId
    )

    @Throws(Error::class)
    @Transactional
    fun save(dto: ObservationDto, inspectionId: String, updatedBy: Int): ObservationDto {
        val inspection = inspectionRepository.findByUuidAndDeletedIsFalse(inspectionId)
        if (!inspection.isPresent) {
            throw invalidInspectionUuid
        }
        var createdBy = updatedBy
        val observation = observationRepository.findById(dto.uuid)
        if (observation.isPresent) {
            createdBy = observation.get().createdBy
        }
        val saved = observationRepository.save(dto.toEntity(createdBy, updatedBy, inspectionId))
        if (dto.observationDefects != null) {
            observationDefectService.save(dto.observationDefects,
                                          inspectionId,
                                          dto.uuid,
                                          updatedBy,
                                          inspection.get().structureId)
        }
        return saved.toDto()
    }

    @Transactional
    fun save(list: List<ObservationDto>, inspectionId: String, updatedBy: Int): List<ObservationDto> {
        return list.map { dto -> save(dto, inspectionId, updatedBy) }
    }

    fun findAllByInspectionUuidAndNotDeleted(uuid: String): List<ObservationDto> {
        return observationRepository.findAllByInspectionIdAndDeletedIsFalse(uuid).map { o -> o.toDto() }
    }

    @Throws(Error::class)
    fun delete(id: String, inspectionId: String) {
        val optional = observationRepository.findByUuidAndDeletedIsFalse(id)
        if (!optional.isPresent) {
            throw Error(102, "Invalid observation uuid")
        }
        val observation = optional.get()
        if (observation.inspectionId != inspectionId) {
            throw invalidInspectionUuid
        }
        observation.deleted = true
        observationRepository.save(observation);
    }

    fun getTotalQuantity(observation: Observation): Int = observation.dimensionNumber ?: 0

    fun getCsValue(observation: Observation, conditionType: ConditionType): Int {
        return when (conditionType) {
            ConditionType.GOOD ->
                getTotalQuantity(observation) - ConditionType.LIST_EXCLUDING_GOOD.sumBy { getCsValue(observation, conditionType) }
            else -> when (observation.subcomponent?.measureUnit?.toLowerCase()) {
                MEASURE_TYPE_EACH -> calculateCsProcessB(observation, conditionType)
                else -> calculateCsProcessA(observation, conditionType)
            }
        }
    }

    private fun calculateCsProcessA(observation: Observation, conditionType: ConditionType): Int {
        val defects = observationDefectService.findAllByObservationIdAndNotDeleted(observation.uuid)
        return defects
                .filter { it.type == StructuralType.STRUCTURAL }
                .filter { it.conditionId != null && conditionRepository.findFirstById(it.conditionId)?.type == conditionType }
                .sumBy { it.size?.toIntOrNull() ?: 0 }
    }

    private fun calculateCsProcessB(observation: Observation, conditionType: ConditionType): Int {
        val defects = observationDefectService.findAllByObservationIdAndNotDeleted(observation.uuid)
        val worstConditionType = defects
                .filter { it.type == StructuralType.STRUCTURAL }
                .mapNotNull { it.conditionId?.let { conditionRepository.findFirstById(it)?.type } }
                .max()

        return if (conditionType == worstConditionType) defects.size else 0
    }

    fun getHealthIndex(observation: Observation): Double {
        val totalQuantity =  getTotalQuantity(observation)
        if (totalQuantity <= 0) return 0.0

        return ConditionType.values().sumByDouble {
            getCsValue(observation, it) * it.csWeight / totalQuantity
        }
    }
}
