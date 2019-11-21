package com.uav_recon.app.api.services

import com.uav_recon.app.api.entities.db.Inspection
import com.uav_recon.app.api.entities.requests.bridge.InspectionDto
import com.uav_recon.app.api.entities.requests.bridge.InspectionReport
import com.uav_recon.app.api.entities.requests.bridge.LocationDto
import com.uav_recon.app.api.entities.requests.bridge.Weather
import com.uav_recon.app.api.repositories.InspectionRepository
import org.springframework.stereotype.Service
import java.util.*
import javax.transaction.Transactional

@Service
class InspectionService(
        val inspectionRepository: InspectionRepository,
        val observationService: ObservationService,
        val weatherService: WeatherService) {

    fun Inspection.toDto() = InspectionDto(
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
        observations = observationService.findAllByInspectionIdAndNotDeleted(uuid),
        spansCount = spansCount
    )

    fun InspectionDto.toEntity(weather: Weather?, createdBy: Int, updatedBy: Int) = Inspection(
        id = "",
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
        spansCount = spansCount,
        temperature = weather?.temperature,
        humidity = weather?.humidity,
        wind = weather?.wind,
        createdBy = createdBy,
        updatedBy = updatedBy
    )

    @Transactional
    fun save(dto: InspectionDto, updatedBy: Int): InspectionDto {
        var createdBy = updatedBy
        val inspection = inspectionRepository.findById(dto.uuid)
        if (inspection.isPresent) {
            createdBy = inspection.get().createdBy
        }
        val saved =
                inspectionRepository.save(dto.toEntity(weatherService.getWeather(dto.location?.latitude,
                                                                                 dto.location?.longitude),
                                                       createdBy,
                                                       updatedBy))
        if (dto.observations != null) {
            observationService.save(dto.observations, dto.uuid, updatedBy)
        }
        return saved.toDto()
    }

    fun listNotDeleted(userId: Int): List<InspectionDto> {
        return inspectionRepository.findAllByDeletedIsFalseAndCreatedBy(userId).map { i -> i.toDto() };
    }

    fun delete(id: String) {
        val optional = inspectionRepository.findById(id)
        if (optional.isPresent) {
            val inspection = optional.get()
            inspection.deleted = true
            inspectionRepository.save(inspection)
        } else {
            throw Error(101, "Invalid inspection UUID")
        }
    }

    fun find(id: String): Optional<InspectionDto> {
        val optional = inspectionRepository.findById(id)
        if (optional.isPresent) {
            return Optional.of(optional.get().toDto());
        }
        return Optional.empty();
    }

}
