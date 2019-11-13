package com.uav_recon.app.api.entities.requests.bridge

import java.io.Serializable

data class Weather(
        val temperature: Double?,
        val humidity: Double?,
        val wind: Double?
) : Serializable
