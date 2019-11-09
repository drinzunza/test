package com.uav_recon.app.api.entities.requests.bridge

import java.io.Serializable
import java.time.ZonedDateTime

data class Photo(
        val id: String,
        val uuid: String,
        val link: String,
        val createdAt: ZonedDateTime?,
        val location: Location?,
        val drawables: String?
) : Serializable
