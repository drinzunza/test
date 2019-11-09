package com.uav_recon.app.api.entities.requests.bridge

import java.io.Serializable
import java.util.*

data class InspectionDto(
        val id: String,
        val uuid: String,
        val observations: List<ObservationDto>,
        val isEditable: Boolean?,
        val startDate: Date?,
        val endDate: Date?,
        val structureId: String?,
        val weather: Weather?,
        val location: Location?,
        val status: InspectionStatus?,
        val report: InspectionReport?,
        val generalSummary: String?,
        val sgrRating: String?,
        val termRating: TermRating?
) : Serializable
