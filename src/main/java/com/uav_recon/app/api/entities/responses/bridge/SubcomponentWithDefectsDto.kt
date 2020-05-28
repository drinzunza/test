package com.uav_recon.app.api.entities.responses.bridge

import com.fasterxml.jackson.annotation.JsonInclude
import java.io.Serializable

@JsonInclude(JsonInclude.Include.NON_NULL)
data class SubcomponentWithDefectsDto(
        val id: String? = null,
        val name: String,
        val deleted: Boolean? = null,
        val defects: List<DefectSaveDto>?
) : Serializable