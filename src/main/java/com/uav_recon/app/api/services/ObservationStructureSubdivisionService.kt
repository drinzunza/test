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