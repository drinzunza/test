package com.uav_recon.app.api.entities.responses.bridge

import com.fasterxml.jackson.annotation.JsonInclude
import com.uav_recon.app.api.entities.db.StructureComponentType
import java.io.Serializable

@JsonInclude(JsonInclude.Include.NON_NULL)
data class ComponentTypesDto(
        val type: StructureComponentType? = null,
        val components: List<ComponentWithSubcomponentDto>
) : Serializable