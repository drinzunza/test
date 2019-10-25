package com.uav_recon.app.api.entities.responses.bridge

import java.io.Serializable
import java.util.*

data class ReportResponse(
        val id: Int,
        val date: Date?,
        val file: String?,
        val inspectionId: Int?
) : Serializable