package com.uav_recon.app.api.entities.requests.bridge

import com.fasterxml.jackson.annotation.JsonInclude
import java.io.Serializable

@JsonInclude(JsonInclude.Include.NON_NULL)
data class InspectionUsersDto(
        val inspectionId: String,
        val inspectors: List<Long>
) : Serializable