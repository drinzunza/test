package com.uav_recon.app.api.entities.requests.bridge

import com.fasterxml.jackson.annotation.JsonInclude
import java.io.Serializable

@JsonInclude(JsonInclude.Include.NON_NULL)
data class PhotoUpdateDto(
        val observationDefectId: String?,
        val link: String?,
        var name: String?,
        var latitude: Double?,
        var longitude: Double?,
        var altitude: Double?,
        var drawables: String?,
        var deleted: Boolean?,
        val fields: List<String>
) : Serializable
