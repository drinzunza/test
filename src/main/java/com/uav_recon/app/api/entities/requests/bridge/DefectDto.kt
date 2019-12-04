package com.uav_recon.app.api.entities.requests.bridge

import com.fasterxml.jackson.annotation.JsonInclude
import java.io.Serializable

@JsonInclude(JsonInclude.Include.NON_NULL)
data class DefectDto(
        var id: String,
        var name: String,
        var number: Int? = null,
        var conditionIds: List<String>,
        var isDeleted: Boolean? = null
) : Serializable