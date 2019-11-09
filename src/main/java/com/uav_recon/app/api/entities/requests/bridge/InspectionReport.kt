package com.uav_recon.app.api.entities.requests.bridge

import java.io.Serializable
import java.time.ZonedDateTime

data class InspectionReport(
        val id: Int,
        val link: String,
        val date: ZonedDateTime?
) : Serializable
