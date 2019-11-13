package com.uav_recon.app.api.entities.requests.bridge

import java.io.Serializable

data class LocationDto(
        val latitude: Double?,
        val longitude: Double?,
        val altitude: Double?
) : Serializable
