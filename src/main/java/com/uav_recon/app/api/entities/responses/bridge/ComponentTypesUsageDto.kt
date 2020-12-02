package com.uav_recon.app.api.entities.responses.bridge

import com.fasterxml.jackson.annotation.JsonInclude
import java.io.Serializable

@JsonInclude(JsonInclude.Include.NON_NULL)
data class ComponentTypesUsageDto(
        val structural: Int,
        val maintenance: Int
) : Serializable