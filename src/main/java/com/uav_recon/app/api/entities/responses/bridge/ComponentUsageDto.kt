package com.uav_recon.app.api.entities.responses.bridge

import com.fasterxml.jackson.annotation.JsonInclude
import java.io.Serializable

@JsonInclude(JsonInclude.Include.NON_NULL)
data class ComponentUsageDto(
        val componentId: String,
        val componentName: String,
        val observationDefectsCount: Int
) : Serializable