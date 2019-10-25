package com.uav_recon.app.api.entities.responses.bridge

import java.util.*

class InspectionResponse(
        val id: Int,
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
)