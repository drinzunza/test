package com.uav_recon.app.api.entities.requests.bridge

import com.fasterxml.jackson.annotation.JsonInclude
import com.uav_recon.app.api.entities.db.StructureComponentType
import java.io.Serializable

@JsonInclude(JsonInclude.Include.NON_NULL)
data class ComponentDto(
        val id: String,
        val name: String,
        val type: StructureComponentType? = null,
        val companyId: Long? = null,
        val deleted: Boolean? = null,
        val subComponentIds: List<String>
) : Serializable