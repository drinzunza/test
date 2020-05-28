package com.uav_recon.app.api.entities.requests.bridge

import com.fasterxml.jackson.annotation.JsonInclude
import com.uav_recon.app.api.entities.db.*
import com.uav_recon.app.api.entities.responses.bridge.CompanyWithComponentsDto
import java.io.Serializable

@JsonInclude(JsonInclude.Include.NON_NULL)
data class DictionariesDto(
        val companies: List<CompanyWithComponentsDto>
) : Serializable