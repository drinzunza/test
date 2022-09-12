package com.uav_recon.app.api.entities.requests.bridge

import com.fasterxml.jackson.annotation.JsonInclude
import com.uav_recon.app.api.entities.db.InspectionStatus
import java.io.Serializable
import java.time.OffsetDateTime

@JsonInclude(JsonInclude.Include.NON_NULL)
data class ObservationUpdateDto(
        val id: String?,
        val structuralComponentId: String?,
        val subComponentId: String?,
        val drawingNumber: String?,
        val roomNumber: String?,
        val dimensionNumber: Int?,
        val locationDescription: String?,
        val inspected: Boolean?,
        val healthIndex: Double?,
        val generalSummary: String?,
        val fields: List<String>
) : Serializable
