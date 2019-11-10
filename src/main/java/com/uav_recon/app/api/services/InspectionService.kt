package com.uav_recon.app.api.services

import com.uav_recon.app.api.entities.db.Inspection
import com.uav_recon.app.api.entities.requests.bridge.InspectionDto
import com.uav_recon.app.api.entities.requests.bridge.InspectionReport
import com.uav_recon.app.api.entities.requests.bridge.LocationDto
import com.uav_recon.app.api.entities.requests.bridge.Weather
import com.uav_recon.app.api.repositories.InspectionRepository
import org.springframework.stereotype.Service
import javax.transaction.Transactional

@Service
class InspectionService(
        val inspectionRepository: InspectionRepository,
        val observationService: ObservationService) {

    fun Inspection.toDto() = InspectionDto(
        id = id,
        uuid = uuid,
        location = if (latitude != null) LocationDto(latitude, longitude, altitude) else null,
        endDate = endDate,
        startDate = startDate,
        generalSummary = generalSummary,
        isEditable = isEditable,
        sgrRating = sgrRating,
        structureId = structureId,
        report = if (reportId != null) InspectionReport(reportId, reportLink, reportDate) else null,
        status = status,
        termRating = termRating,
        weather = if (temperature != null) Weather(temperature, humidity, wind) else null,
        observations = observationService.findAllByInspectionId(uuid)
    )

    fun InspectionDto.toEntity(createdBy: Int, updatedBy: Int) = Inspection(
        id = id,
        uuid = uuid,
        latitude = location?.latitude,
        longitude = location?.longitude,
        altitude = location?.altitude,
        endDate = endDate,
        startDate = startDate,
        generalSummary = generalSummary,
        sgrRating = sgrRating,
        structureId = structureId,
        status = status,
        termRating = termRating,
        createdBy = createdBy,
        updatedBy = updatedBy
    )

    @Transactional
    fun save(dto: InspectionDto, updatedBy: Int): InspectionDto {
        if (dto.observations != null) {
            observationService.save(dto.observations, dto.uuid, updatedBy)
        }
        var createdBy = updatedBy
        val inspection = inspectionRepository.findById(dto.uuid)
        if (inspection.isPresent) {
            createdBy = inspection.get().createdBy
        }
        return inspectionRepository.save(dto.toEntity(createdBy, updatedBy)).toDto()
    }

    fun list(): List<InspectionDto> {
        return inspectionRepository.findAll().map { i -> i.toDto() };
    }

    fun delete(id: String) {
        inspectionRepository.deleteById(id)
    }

}
