package com.uav_recon.app.api.entities.responses.bridge

import com.fasterxml.jackson.annotation.JsonInclude
import java.io.Serializable

@JsonInclude(JsonInclude.Include.NON_NULL)
data class DefectSaveDto(
        var id: String? = null,
        var name: String,
        var number: Int? = null,
        var deleted: Boolean? = null
) : Serializable