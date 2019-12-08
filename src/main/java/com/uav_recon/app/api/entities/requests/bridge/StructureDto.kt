package com.uav_recon.app.api.entities.requests.bridge

import com.fasterxml.jackson.annotation.JsonInclude
import java.io.Serializable

@JsonInclude(JsonInclude.Include.NON_NULL)
data class StructureDto(
        val id: String,
        val name: String,
        val type: String,
        val primaryOwner: String? = null,
        val caltransBridgeNo: String? = null,
        val postmile: Double? = null,
        val beginStationing: String? = null,
        val endStationing: String? = null,
        val isDeleted: Boolean? = null,
        val structuralComponentIds: List<String>
) : Serializable