package com.uav_recon.app.api.controllers.dto.admin

import com.fasterxml.jackson.annotation.JsonInclude
import com.uav_recon.app.api.entities.db.StructureComponentType
import java.io.Serializable

@JsonInclude(JsonInclude.Include.NON_NULL)
data class AdminStructureOutDTO(
        var id: String = "",
        var code: String = "",
        var name: String = "",
        var type: StructureComponentType? = null,
        var clientId: Long? = null ,
        var caltransBridgeNo: String? = null,
        var postmile: Double? = null,
        var beginStationing: String? = null,
        var endStationing: String? = null
) : Serializable