package com.uav_recon.app.api.entities.requests.bridge.templates

import com.fasterxml.jackson.annotation.JsonInclude
import com.uav_recon.app.api.entities.db.templates.SubcomponentAndStructure
import java.io.Serializable

@JsonInclude(JsonInclude.Include.NON_NULL)
data class SubcomponentAndStructuresDto(
        val subcomponentAndStructures: List<SubcomponentAndStructure>
) : Serializable