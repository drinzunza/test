package com.uav_recon.app.api.controllers.dto.admin

import com.fasterxml.jackson.annotation.JsonInclude
import java.io.Serializable
import javax.validation.constraints.NotEmpty

@JsonInclude(JsonInclude.Include.NON_NULL)
data class AdminStructureInDTO(
        var id: String = "",
        @NotEmpty
        var code: String,
        @NotEmpty
        var name: String,
        @NotEmpty
        var type: String,
        @NotEmpty
        var clientId: Long? = null,
        var caltransBridgeNo: String = "",
        var postmile: Double? = null,
        var beginStationing: String? = null,
        var endStationing: String? = null
) : Serializable