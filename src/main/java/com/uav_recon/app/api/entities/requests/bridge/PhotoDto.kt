package com.uav_recon.app.api.entities.requests.bridge

import com.fasterxml.jackson.annotation.JsonInclude
import java.io.Serializable
import java.time.OffsetDateTime

@JsonInclude(JsonInclude.Include.NON_NULL)
data class PhotoDto(
        val uuid: String,
        var link: String?,
        var name: String?,
        val createdAt: OffsetDateTime?,
        val location: LocationDto?,
        val drawables: String?
) : Serializable
