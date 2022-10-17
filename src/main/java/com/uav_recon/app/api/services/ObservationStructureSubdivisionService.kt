package com.uav_recon.app.api.services

import com.uav_recon.app.api.entities.db.*
import com.uav_recon.app.api.entities.requests.bridge.ObservationStructureSubdivisionDto
import com.uav_recon.app.api.entities.requests.bridge.toEntity
import com.uav_recon.app.api.repositories.*
import org.springframework.stereotype.Service

@Service
class ObservationStructureSubdivisionService(
    private val observationStructureSubdivisionRepository: ObservationStructureSubdivisionRepository,
    private val inspectionRepository: InspectionRepository,
    private val observationRepository: ObservationRepository,
    private val observationDefectRepository: ObservationDefectRepository,
    private val structureSubdivisionRepository: StructureSubdivisionRepository
) : BaseService() {

    fun ObservationStructureSubdivision.toDto() = ObservationStructureSubdivisionDto(
        uuid = uuid,
        structureSubdivisionId = structureSubdivisionId,
        observationId = observationId,
        computedHealthIndex = calculateSubdivisionObservationHealthIndex(this),
//        weightedHealthIndex = calculateWeightedSubdivisionObservationHealthIndex(this),
        dimensionNumber = dimensionNumber
    )

    fun calculateSubdivisionObservationHealthIndex(observation: ObservationStructureSubdivision): Double? {
        var subdivisionObservationHI = 0.0
        val observationDefects = observationDefectRepository
            .findAllByObservationIdAndStructureSubdivisionIdAndDeletedIsFalse(observation.observationId, observation.structureSubdivisionId)
        if (observationDefects.isEmpty()) {
            return subdivisionObservationHI
        }

        val totalDefectSize = observationDefects.sumBy { it.size?.toIntOrNull() ?: 0 }
        if (totalDefectSize == 0) {
            return subdivisionObservationHI
        }

        val cs1 = getCsValue(observationDefects, ConditionType.GOOD)
        val cs2 = getCsValue(observationDefects, ConditionType.FAIR)
        val cs3 = getCsValue(observationDefects, ConditionType.POOR)
        val cs4 = getCsValue(observationDefects, ConditionType.SEVERE)
        subdivisionObservationHI = ((cs1 * ConditionType.GOOD.csWeight)
                + (cs2 * ConditionType.FAIR.csWeight)
                + (cs3 * ConditionType.POOR.csWeight)
                + (cs4 * ConditionType.SEVERE.csWeight)
                ) / totalDefectSize
        return if (subdivisionObservationHI.isNaN()) 0.0 else subdivisionObservationHI
    }

    fun calculateWeightedSubdivisionObservationHealthIndex(observation: ObservationStructureSubdivision): Double? {
        var weightedSubdivisionObservationHI = 0.0
        val mainObservation = observationRepository.findFirstByUuidAndDeletedIsFalse(observation.observationId)
            ?: return weightedSubdivisionObservationHI
        val subdivision = structureSubdivisionRepository.findFirstByUuid(observation.structureSubdivisionId)
            ?: return weightedSubdivisionObservationHI
        if (mainObservation.structuralComponentId == null) {
            return weightedSubdivisionObservationHI
        }

        val componentHI = getSubdivisionComponentHealthIndex(
            subdivision.inspectionId,
            observation.structureSubdivisionId,
            mainObservation.structuralComponentId!!
        )
        val fDotBhi = mainObservation.subcomponent?.fdotBhiValue ?: return weightedSubdivisionObservationHI
        weightedSubdivisionObservationHI = fDotBhi * componentHI
        return weightedSubdivisionObservationHI
    }

    fun getCsValue(defects: List<ObservationDefect>, conditionType: ConditionType): Int {
        return defects
            .filter { it.type == StructuralType.STRUCTURAL }
            .filter { it.condition?.type == conditionType }
            .sumBy { it.size?.toIntOrNull() ?: 0 }
    }

    fun getSubdivisionComponentHealthIndex(
        inspectionId: String,
        structureSubdivisionId: String,
        structuralComponentId: String
    ): Double {
        var subcomponentHIWeightTotal = 0.0
        var subcomponentWeightTotal = 0
        val observations = observationRepository
            .findAllByInspectionIdAndStructuralComponentIdAndDeletedIsFalse(inspectionId, structuralComponentId)
        val observationDefects =
            observationDefectRepository
                .findAllByDeletedIsFalseAndObservationIdInAndStructureSubdivisionId(
                    observations.map { it.uuid },
                    structureSubdivisionId
                )
        observationDefects
            .groupBy { it.observationId }
            .forEach {
                val defectsList = it.value
                if (defectsList.isEmpty()) {
                    return@forEach
                }

                val totalDefectSize = defectsList.sumBy { defect -> defect.size?.toIntOrNull() ?: 0 }
                if (totalDefectSize == 0) {
                    return@forEach
                }

                val cs1 = getCsValue(defectsList, ConditionType.GOOD)
                val cs2 = getCsValue(defectsList, ConditionType.FAIR)
                val cs3 = getCsValue(defectsList, ConditionType.POOR)
                val cs4 = getCsValue(defectsList, ConditionType.SEVERE)
                val subdivisionObservationHI = ((cs1 * ConditionType.GOOD.csWeight)
                        + (cs2 * ConditionType.FAIR.csWeight)
                        + (cs3 * ConditionType.POOR.csWeight)
                        + (cs4 * ConditionType.SEVERE.csWeight)
                        ) / totalDefectSize
                val observation = observationRepository.findFirstByUuidAndDeletedIsFalse(it.key)
                val fDotValueWeight = observation?.subcomponent?.fdotBhiValue ?: 0
                subcomponentWeightTotal += fDotValueWeight
                subcomponentHIWeightTotal += (subdivisionObservationHI * fDotValueWeight)
            }
        if (subcomponentWeightTotal == 0) {
            return 0.0
        }
        return subcomponentHIWeightTotal / subcomponentWeightTotal
    }
    @Throws(Error::class)
    fun save(
        inspectionId: String,
        structureSubdivisionId: String,
        dto: ObservationStructureSubdivisionDto
    ): ObservationStructureSubdivisionDto {
        // check if structure subdivision and observation are under the same inspection
        val inspection = inspectionRepository.findFirstByUuid(inspectionId)
            ?: throw Error(400, "Inspection does not exist")
        val observation = observationRepository.findFirstByUuid(dto.observationId)
            ?: throw Error(400, "Observation does not exist")
        val structureSubdivision = structureSubdivisionRepository.findFirstByUuid(structureSubdivisionId)
            ?: throw Error(400, "Structure subdivision does not exist")

        if (observation.inspectionId != inspection.uuid) {
            throw Error(400, "Observation is not under specified inspection")
        }

        if (structureSubdivision.inspectionId != inspection.uuid) {
            throw Error(400, "Structure subdivision is not under specified inspection")
        }

        if (observation.dimensionNumber == null) {
            throw Error(400, "Observation has no dimension number")
        }

        // check if observation structure subdivision dimension is acceptable
        var currentObservationStructureSubdivisions = observationStructureSubdivisionRepository.findAllByObservationId(
            dto.observationId
        )

        // FOR TESTING: filter out allocations with deleted structure subdivisions
        val inspectionStructureSubdivisionIds = structureSubdivisionRepository.findAllByInspectionId(inspectionId).map { it.uuid }
        currentObservationStructureSubdivisions = currentObservationStructureSubdivisions.filter {
            it.uuid != dto.uuid && it.structureSubdivisionId in inspectionStructureSubdivisionIds
        }

        val currentDimensionTotal = currentObservationStructureSubdivisions.fold(0){
                total, next -> total + next.dimensionNumber
        }

        if (currentDimensionTotal + dto.dimensionNumber > observation.dimensionNumber!!) {
            val availableDimensionNumber = observation.dimensionNumber!! - currentDimensionTotal
            throw Error(400, "The specified dimension number is greater than the available dimension number (${availableDimensionNumber})")
        }

        return observationStructureSubdivisionRepository.save(dto.toEntity()).toDto()
    }

    fun delete(uuid: String) {
        val observationStructureSubdivision = observationStructureSubdivisionRepository.findFirstByUuid(uuid)
            ?: throw Error(400, "Specified observation structure subdivision does not exist")

        return observationStructureSubdivisionRepository.delete(observationStructureSubdivision)
    }

    fun getAllByStructureSubdivisionId(structureSubdivisionId: String): List<ObservationStructureSubdivisionDto> {
        val observationStructureSubdivisions =
            observationStructureSubdivisionRepository.findAllByStructureSubdivisionId(structureSubdivisionId)

        return observationStructureSubdivisions.map { it.toDto() }
    }
}