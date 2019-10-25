package com.uav_recon.app.api.entities.responses.bridge

import java.io.Serializable

data class ConditionResponse(
    val id: Int,
    val description: String?,
    val type: String?,
    val defectId: Int?
) : Serializable