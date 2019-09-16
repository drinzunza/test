package com.uav_recon.app.api.entities

import java.io.Serializable

interface Location : Serializable {

    val latitude: Double
    val longitude: Double
    val altitude: Double?

    data class Simple(
        override val latitude: Double,
        override val longitude: Double,
        override val altitude: Double? = null
    ) : Location {

        constructor(location: Location) : this(
            location.latitude,
            location.longitude,
            location.altitude
        )

        override fun toString(): String {
            return "Latitude=$latitude, longitude=$longitude, altitude=$altitude"
        }
    }
}