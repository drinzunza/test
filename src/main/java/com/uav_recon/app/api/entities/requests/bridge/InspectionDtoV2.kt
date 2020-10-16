package com.uav_recon.app.api.entities.requests.bridge

import com.fasterxml.jackson.annotation.JsonInclude
import com.uav_recon.app.api.entities.db.Inspection
import com.uav_recon.app.api.entities.db.InspectionStatus
import com.uav_recon.app.api.entities.db.toInspectionTermRating
import java.io.Serializable
import java.time.OffsetDateTime

@JsonInclude(JsonInclude.Include.NON_NULL)
data class InspectionDtoV2(
        val uuid: String,
        val observations: List<ObservationDto>?,
        val isEditable: Boolean?,
        val startDate: OffsetDateTime?,
        val endDate: OffsetDateTime?,
        val structureId: String?,
        val structureCode: String?,
        val structureName: String?,
        val weather: Weather?,
        val location: LocationDto?,
        val status: InspectionStatus?,
        val report: InspectionReport?,
        val generalSummary: String?,
        val sgrRating: String?,
        val termRating: Double?,
        val spansCount: Int?,
        val projectId: Long?,
        val archived: Boolean?,
        val inspectors: List<SimpleUserDto>?
) : Serializable

fun InspectionDtoV2.toEntity(weather: Weather?, createdBy: Int, updatedBy: Int) = Inspection(
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
        projectId = projectId,
        archived = archived,
        createdBy = createdBy,
        updatedBy = updatedBy
)

fun InspectionDtoV2.toDtoV1() = InspectionDto(
        uuid = uuid,
        location = location,
        endDate = endDate,
        startDate = startDate,
        generalSummary = generalSummary,
        isEditable = isEditable,
        sgrRating = sgrRating,
        structureId = structureId,
        structureCode = structureCode,
        structureName = structureName,
        report = report,
        status = status,
        termRating = termRating?.toInspectionTermRating(),
        weather = weather,
        observations = observations,
        spansCount = spansCount,
        projectId = projectId,
        archived = archived,
        inspectors = inspectors
)

fun InspectionDto.toDtoV2() = InspectionDtoV2(
        uuid = uuid,
        location = location,
        endDate = endDate,
        startDate = startDate,
        generalSummary = generalSummary,
        isEditable = isEditable,
        sgrRating = sgrRating,
        structureId = structureId,
        structureCode = structureCode,
        structureName = structureName,
        report = report,
        status = status,
        termRating = termRating?.value,
        weather = weather,
        observations = observations,
        spansCount = spansCount,
        projectId = projectId,
        archived = archived,
        inspectors = inspectors
)