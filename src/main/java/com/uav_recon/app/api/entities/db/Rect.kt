package com.uav_recon.app.api.entities.db

import java.io.Serializable

data class Rect(
        val startX: Double,
        val startY: Double,
        val endX: Double,
        val endY: Double
) : Serializable