package com.uav_recon.app.api.entities.responses.bridge

import java.io.Serializable

data class MaterialResponse(
        val id: Int,
        val name: String?,
        val description: String?,
        val measureUnit: String?,
        val subcomponentId: Int?
) : Serializable