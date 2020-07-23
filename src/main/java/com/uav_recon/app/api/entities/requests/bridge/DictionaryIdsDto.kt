package com.uav_recon.app.api.entities.requests.bridge

import com.fasterxml.jackson.annotation.JsonInclude
import java.io.Serializable

@JsonInclude(JsonInclude.Include.NON_NULL)
data class DictionaryIdsDto(
        val componentIds: List<String>?,
        val subcomponentIds: List<String>?,
        val defectIds: List<String>?
) : Serializable