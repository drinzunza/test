package com.uav_recon.app.api.entities.requests.bridge

import com.fasterxml.jackson.annotation.JsonInclude
import com.uav_recon.app.api.entities.db.InspectionStatus
import java.io.Serializable
import java.time.OffsetDateTime

@JsonInclude(JsonInclude.Include.NON_NULL)
data class InspectionUpdateDto(
        val isEditable: Boolean?,
        val startDate: OffsetDateTime?,
        val endDate: OffsetDateTime?,
        val structureId: String?,
        val location: LocationDto?,
        val status: InspectionStatus?,
        val report: InspectionReport?,
        var generalSummary: String?,
        val sgrRating: String?,
        val termRating: Double?,
        val spansCount: Int?,
        val projectId: Long?,
        val archived: Boolean?,
        val fields: List<String>
) : Serializable
