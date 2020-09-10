package com.uav_recon.app.api.entities.requests.bridge

import com.fasterxml.jackson.annotation.JsonInclude
import com.uav_recon.app.api.entities.db.InspectionStatus
import com.uav_recon.app.api.entities.db.InspectionTermRating
import com.uav_recon.app.api.entities.db.Structure
import java.io.Serializable
import java.time.OffsetDateTime

@JsonInclude(JsonInclude.Include.NON_NULL)
data class InspectionDto(
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
        val termRating: InspectionTermRating?,
        val spansCount: Int?,
        val projectId: Long?,
        val inspectors: List<SimpleUserDto>?
) : Serializable
