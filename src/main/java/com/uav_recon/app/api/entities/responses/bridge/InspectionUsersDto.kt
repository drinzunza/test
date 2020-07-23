package com.uav_recon.app.api.entities.responses.bridge

import com.fasterxml.jackson.annotation.JsonInclude
import com.uav_recon.app.api.entities.requests.bridge.SimpleUserDto
import java.io.Serializable

@JsonInclude(JsonInclude.Include.NON_NULL)
data class InspectionUsersDto(
        val inspectionId: String,
        val inspectors: List<SimpleUserDto>
) : Serializable