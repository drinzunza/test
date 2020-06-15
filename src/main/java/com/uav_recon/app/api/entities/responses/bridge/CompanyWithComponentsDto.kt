package com.uav_recon.app.api.entities.responses.bridge

import com.fasterxml.jackson.annotation.JsonInclude
import com.uav_recon.app.api.entities.db.CompanyType
import java.io.Serializable

@JsonInclude(JsonInclude.Include.NON_NULL)
data class CompanyWithComponentsDto(
        val id: Long,
        val name: String,
        val logo: String?,
        val type: CompanyType?,
        val components: List<ComponentWithSubcomponentDto>
) : Serializable