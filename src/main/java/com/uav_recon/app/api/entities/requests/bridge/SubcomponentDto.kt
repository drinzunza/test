package com.uav_recon.app.api.entities.requests.bridge

import com.fasterxml.jackson.annotation.JsonInclude
import java.io.Serializable

@JsonInclude(JsonInclude.Include.NON_NULL)
data class SubcomponentDto(
        val id: String,
        val name: String,
        val number: Int? = null,
        val fdotBhiValue: Int? = null,
        val description: String? = null,
        val measureUnit: String? = null,
        val componentId: String,
        val groupName: String? = null,
        val deleted: Boolean? = null,
        val defectIds: List<String>,
        var observationNameIds: List<String>
) : Serializable