package com.uav_recon.app.api.entities.requests.bridge

import com.fasterxml.jackson.annotation.JsonFormat
import com.fasterxml.jackson.annotation.JsonInclude
import java.io.Serializable
import java.time.OffsetDateTime

@JsonInclude(JsonInclude.Include.NON_NULL)
data class PhotoDto(
        val uuid: String,
        var link: String?,
        var thumbLink: String?,
        var annotatedLink: String?,
        var name: String?,
        @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss.SSSXXX")
        var createdAt: OffsetDateTime?,
        val location: LocationDto?,
        val drawables: String?,
        var observationDefectId: String?,
        var previousPhotoId: String?
) : Serializable
