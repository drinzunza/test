package com.uav_recon.app.api.controllers.dto.admin

import com.fasterxml.jackson.annotation.JsonInclude
import com.uav_recon.app.api.entities.db.StructureComponentType
import java.io.Serializable
import java.util.*
import javax.validation.constraints.NotEmpty

@JsonInclude(JsonInclude.Include.NON_NULL)
data class AdminStructureInDTO(
        var id: String? = UUID.randomUUID().toString(),
        @NotEmpty
        var name: String,
        @NotEmpty
        var type: StructureComponentType,
        @NotEmpty
        var clientId: Long? = null,
        var caltransBridgeNo: String = "",
        var postmile: Double? = null,
        var beginStationing: String? = null,
        var endStationing: String? = null
) : Serializable