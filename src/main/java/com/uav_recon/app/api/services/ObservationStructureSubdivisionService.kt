package com.uav_recon.app.api.services

import com.uav_recon.app.api.entities.db.toDto
import com.uav_recon.app.api.entities.requests.bridge.ObservationStructureSubdivisionDto
import com.uav_recon.app.api.entities.requests.bridge.toEntity
import com.uav_recon.app.api.repositories.InspectionRepository
import com.uav_recon.app.api.repositories.ObservationRepository
import com.uav_recon.app.api.repositories.ObservationStructureSubdivisionRepository
import com.uav_recon.app.api.repositories.StructureSubdivisionRepository
import org.springframework.stereotype.Service

@Service
class ObservationStructureSubdivisionService(
    private val observationStructureSubdivisionRepository: ObservationStructureSubdivisionRepository,
    private val inspectionRepository: InspectionRepository,
    private val observationRepository: ObservationRepository,
    private val structureSubdivisionRepository: StructureSubdivisionRepository
) : BaseService() {

    fun save(
        inspectionId: String,
        structureSubdivisionId: String,
        dto: ObservationStructureSubdivisionDto
    ): ObservationStructureSubdivisionDto {
        // check if structure subdivision and observation are under the same inspection
        val inspection = inspectionRepository.findFirstByUuid(inspectionId)
            ?: throw Error("Inspection does not exist")
        val observation = observationRepository.findFirstByUuid(dto.observationId)
            ?: throw Error("Observation does not exist")
        val structureSubdivision = structureSubdivisionRepository.findFirstByUuid(structureSubdivisionId)
            ?: throw Error("Structure subdivision does not exist")

        if (observation.inspectionId != inspection.uuid) {
            throw Error("Observation is not under specified inspection")
        }

        if (structureSubdivision.inspectionId != inspection.uuid) {
            throw Error("Structure subdivision is not under specified inspection")
        }

        if (observation.dimensionNumber == null) {
            throw Error("Observation has no dimension number")
        }

        // check if observation structure subdivision dimension is acceptable
        val currentObservationStructureSubdivisions = observationStructureSubdivisionRepository.findAllByObservationId(
            dto.observationId
        )
        val currentDimensionTotal = currentObservationStructureSubdivisions.filter { it.uuid != dto.uuid }.fold(0){
                total, next -> total + next.dimensionNumber
        }

        if (currentDimensionTotal + dto.dimensionNumber > observation.dimensionNumber!!) {
            throw Error("The specified dimension number is greater than the available dimension number")
        }

        return observationStructureSubdivisionRepository.save(dto.toEntity()).toDto()
    }

    fun delete(uuid: String) {
        val observationStructureSubdivision = observationStructureSubdivisionRepository.findFirstByUuid(uuid)
            ?: throw Error("Specified observation structure subdivision does not exist")

        return observationStructureSubdivisionRepository.delete(observationStructureSubdivision)
    }
}