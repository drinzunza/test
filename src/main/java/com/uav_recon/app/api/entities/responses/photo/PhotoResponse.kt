package com.uav_recon.app.api.entities.responses.photo

import java.io.Serializable
import java.util.*

data class PhotoResponse(
        val id: Int,
        val latitude: Double?,
        val longitude: Double?,
        val altitude: Double?,
        val startX: Double?,
        val startY: Double?,
        val endX: Double?,
        val endY: Double?,
        val createdDate: Date?
) : Serializable