package com.uav_recon.app.api.entities.requests.bridge

import java.io.Serializable

data class Location(
        val latitude: Double,
        val longitude: Double,
        val altitude: Double
) : Serializable
