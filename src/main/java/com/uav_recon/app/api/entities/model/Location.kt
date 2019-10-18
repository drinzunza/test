package com.uav_recon.app.api.entities.model

import java.io.Serializable

class Location(
        val latitude: Double = 0.0,
        val longitude: Double = 0.0,
        val altitude: Double = 0.0
) : Serializable
