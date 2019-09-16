package com.uav_recon.app.api.entities

import java.io.Serializable

interface Weather : Serializable {
    val temperature: Double?
    val humidity: Double?
    val wind: Double?
}