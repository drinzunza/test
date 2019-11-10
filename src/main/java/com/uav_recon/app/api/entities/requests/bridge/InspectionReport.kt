package com.uav_recon.app.api.entities.requests.bridge

import java.io.Serializable
import java.time.OffsetDateTime

data class InspectionReport(
        val id: String?,
        val link: String?,
        val date: OffsetDateTime?
) : Serializable
