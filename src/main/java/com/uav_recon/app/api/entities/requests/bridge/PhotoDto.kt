package com.uav_recon.app.api.entities.requests.bridge

import com.fasterxml.jackson.annotation.JsonInclude
import java.io.Serializable
import java.time.OffsetDateTime

@JsonInclude(JsonInclude.Include.NON_NULL)
data class PhotoDto(
        val id: String,
        val uuid: String,
        val link: String,
        val createdAt: OffsetDateTime?,
        val location: LocationDto?,
        val drawables: String?
) : Serializable
