package com.uav_recon.app.api.entities.requests.bridge

import com.fasterxml.jackson.annotation.JsonInclude
import java.io.Serializable

@JsonInclude(JsonInclude.Include.NON_NULL)
data class SimpleStructureDto(
        val id: String,
        val name: String,
        val code: String
) : Serializable