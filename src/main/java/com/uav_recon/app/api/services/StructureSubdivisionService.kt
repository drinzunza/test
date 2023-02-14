package com.uav_recon.app.api.services

import com.uav_recon.app.api.entities.db.StructureSubdivision
import com.uav_recon.app.api.entities.requests.bridge.StructureSubdivisionDto
import com.uav_recon.app.api.entities.requests.bridge.toEntity
import com.uav_recon.app.api.repositories.InspectionRepository
import com.uav_recon.app.api.repositories.ObservationRepository
import com.uav_recon.app.api.repositories.ObservationStructureSubdivisionRepository
import com.uav_recon.app.api.repositories.StructureSubdivisionRepository
import org.slf4j.LoggerFactory
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional

@Service
class StructureSubdivisionService(
    private val observationRepository: ObservationRepository,
    private val structureSubdivisionRepository: StructureSubdivisionRepository,
    private val observationStructureSubdivisionService: ObservationStructureSubdivisionService,
    private val observationStructureSubdivisionRepository: ObservationStructureSubdivisionRepository,
    private val inspectionRepository: InspectionRepository
) : BaseService() {

    private val logger = LoggerFactory.getLogger(ObservationStructureSubdivisionService::class.java)

    fun StructureSubdivision.toDto() = StructureSubdivisionDto(
        uuid = uuid,
        inspectionId = inspectionId,
        name = name,
        number = number,
        computedSgrRating = calculateSubdivisionSgr(this),
        sgrRating = sgrRating
    )

    fun calculateSubdivisionSgr(subdivision: StructureSubdivision): Double {
        var totalWeight = 0
        var totalWeightedHI = 0.0
        val subdivisionObservations = observationStructureSubdivisionRepository
            .findAllByStructureSubdivisionId(subdivision.uuid)
        if (subdivisionObservations.isEmpty()) {
            return 0.0
        }

        subdivisionObservations.forEach {
//            val mainObservation = observationRepository.findFirstByUuidAndDeletedIsFalse(it.observationId)
            val mainObservation = observationRepository
                .findFirstByUuidAndDeletedIsFalse(it.observationId) ?: return@forEach
//            mainObservation.subcomponent = subcomponentRepository.findFirstById(mainObservation.subComponentId ?: "" )
            val weightedHI = observationStructureSubdivisionService
                .calculateWeightedSubdivisionObservationHealthIndex(it) ?: 0.0
            totalWeightedHI += weightedHI

            if (weightedHI > 0) {
                totalWeight += mainObservation.subcomponent?.fdotBhiValue ?: 0
            }
        }
        if (totalWeight == 0) {
            return 0.0
        }

        return totalWeightedHI / totalWeight
    }

    @Transactional
    @Throws(Error::class)
    fun save(inspectionId: String, dto: StructureSubdivisionDto): StructureSubdivisionDto {
        dto.inspectionId = inspectionId

        // check if inspection exists
        inspectionRepository.findFirstByUuid(inspectionId)
            ?: throw Error(400, "Inspection does not exist")

        // check if subdivision number is unique for the inspection
        val existingSubdivisions = structureSubdivisionRepository.findAllByInspectionId(inspectionId)
        if (existingSubdivisions.filter { it.uuid != dto.uuid }.any { it.number == dto.number }) {
            throw Error(400, "Subdivision number already exists for this inspection")
        }

        val saved = structureSubdivisionRepository.save(dto.toEntity())

        return saved.toDto()
    }

    fun getByUuid(uuid: String): StructureSubdivisionDto? {
        val structureSubdivision = structureSubdivisionRepository.findFirstByUuid(uuid)

        val structureSubdivisionDto = structureSubdivision?.toDto()
        structureSubdivisionDto?.observationStructureSubdivisions = structureSubdivisionDto?.uuid?.let {
            observationStructureSubdivisionService.getAllByStructureSubdivisionId(
                it
            )
        }

        return structureSubdivisionDto
    }

    fun getAllByInspectionId(inspectionId: String): List<StructureSubdivisionDto> {
        val structureSubdivisions = structureSubdivisionRepository.findAllByInspectionId(inspectionId)

        var structureSubdivisionsDto = structureSubdivisions.map { it.toDto() }

        structureSubdivisionsDto.forEach {
            it.observationStructureSubdivisions =
                observationStructureSubdivisionService.getAllByStructureSubdivisionId(it.uuid)
        }

        return structureSubdivisionsDto
    }

    @Throws(Error::class)
    fun delete(uuid: String) {
        val structureSubdivision = structureSubdivisionRepository.findFirstByUuid(uuid)
            ?: throw Error(400, "Specified structure subdivision does not exist")

        structureSubdivisionRepository.delete(structureSubdivision)

        // delete allocations to this structure subdivision
        val allocations = observationStructureSubdivisionService.getAllByStructureSubdivisionId(uuid)
        allocations.forEach { observationStructureSubdivisionService.delete(it.uuid) }
    }
}