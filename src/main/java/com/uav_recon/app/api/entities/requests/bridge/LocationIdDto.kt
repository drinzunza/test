package com.uav_recon.app.api.entities.requests.bridge

import com.fasterxml.jackson.annotation.JsonInclude
import java.io.Serializable

@JsonInclude(JsonInclude.Include.NON_NULL)
data class LocationIdDto(
    val id: String,
    val structureType: String,
    val majorIds: List<String>?,
    val subComponentIds: List<String>?,
    val alwaysShownSpans: List<String>?,
    val iteratedSpanPatterns: List<String>?,
    val deleted: Boolean? = null
) : Serializable
