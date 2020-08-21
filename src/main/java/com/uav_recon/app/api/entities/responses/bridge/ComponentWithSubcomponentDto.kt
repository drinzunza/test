package com.uav_recon.app.api.entities.responses.bridge

import com.fasterxml.jackson.annotation.JsonInclude
import com.uav_recon.app.api.entities.db.StructureComponentType
import java.io.Serializable

@JsonInclude(JsonInclude.Include.NON_NULL)
data class ComponentWithSubcomponentDto(
        var id: String? = null,
        var name: String,
        var type: String? = null,
        var deleted: Boolean? = null,
        var subcomponents: List<SubcomponentWithDefectsDto>?
) : Serializable