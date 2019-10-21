package com.uav_recon.app.api.entities.requests.photo

import java.io.Serializable

data class PhotoRequest(
    val latitude: Double,
    var longitude: Double,
    var altitude: Double,
    var startX: Double,
    var startY: Double,
    var endX: Double,
    var endY: Double
) : Serializable