package com.uav_recon.app.api.entities.requests.bridge

import com.fasterxml.jackson.annotation.JsonInclude
import java.io.Serializable

@JsonInclude(JsonInclude.Include.NON_NULL)
class CannedDescriptionDto(
    val id: String,
    val componentId: String,
    val subcomponentId: String,
    val defectId: String,
    val description: String
) : Serializable