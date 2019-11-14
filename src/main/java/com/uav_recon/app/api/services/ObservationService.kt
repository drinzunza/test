package com.uav_recon.app.api.services

import com.uav_recon.app.api.entities.db.Observation
import com.uav_recon.app.api.entities.requests.bridge.ObservationDto
import com.uav_recon.app.api.repositories.InspectionRepository
import com.uav_recon.app.api.repositories.ObservationRepository
import org.springframework.stereotype.Service
import javax.transaction.Transactional

@Service
class ObservationService(private val inspectionRepository: InspectionRepository,
                         private val observationRepository: ObservationRepository,
                         private val observationDefectService: ObservationDefectService) {

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
        observationDefects = observationDefectService.findAllByObservationId(uuid)
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

    @Transactional
    fun save(dto: ObservationDto, inspectionId: String, updatedBy: Int): ObservationDto {
        if (!inspectionRepository.findById(inspectionId).isPresent) {
            throw invalidInspectionUuid
        }
        if (dto.observationDefects != null) {
            observationDefectService.save(dto.observationDefects, dto.uuid, updatedBy)
        }
        var createdBy = updatedBy
        val observation = observationRepository.findById(dto.uuid)
        if (observation.isPresent) {
            createdBy = observation.get().createdBy
        }
        return observationRepository.save(dto.toEntity(createdBy, updatedBy, inspectionId)).toDto()
    }

    @Transactional
    fun save(list: List<ObservationDto>, inspectionId: String, updatedBy: Int): List<ObservationDto> {
        return list.map { dto -> save(dto, inspectionId, updatedBy) }
    }

    fun findAllByInspectionId(id: String): List<ObservationDto> {
        return observationRepository.findAllByInspectionId(id).map { o -> o.toDto() }
    }

    fun delete(id: String, inspectionId: String) {
        val optional = observationRepository.findById(id)
        if (optional.isPresent && optional.get().inspectionId != inspectionId) {
            throw invalidInspectionUuid
        }
        observationRepository.deleteById(id);
    }

}
