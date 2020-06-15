package com.uav_recon.app.api.entities.requests.bridge

import com.fasterxml.jackson.annotation.JsonInclude
import com.uav_recon.app.api.entities.db.StructureComponentType
import java.io.Serializable

@JsonInclude(JsonInclude.Include.NON_NULL)
data class StructureDto(
        val id: String,
        val code: String,
        val name: String,
        val type: StructureComponentType,
        val primaryOwner: String? = null,
        val caltransBridgeNo: String? = null,
        val postmile: Double? = null,
        val beginStationing: String? = null,
        val endStationing: String? = null,
        val deleted: Boolean? = null,
        val companyId: Long? = null,
        val structuralComponentIds: List<String>
) : Serializable