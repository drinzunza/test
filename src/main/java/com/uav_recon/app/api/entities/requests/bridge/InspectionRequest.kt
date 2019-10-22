package com.uav_recon.app.api.entities.requests.bridge

import java.io.Serializable
import java.util.*

data class InspectionRequest(
        val startDate: Date?,
        val endDate: Date?,
        val structureId: Int?,
        val status: String?,
        val companyId: Int?,
        val inspectorId: Int?,
        val generalSummary: String?,
        val termRating: String?,
        val sgrRating: String?,
        val temperature: Double?,
        val humidity: Double?,
        val wind: Double?
) : Serializable