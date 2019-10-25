package com.uav_recon.app.api.entities.responses.bridge

import java.io.Serializable

class SubcomponentResponse(
        val id: Int,
        val name: String?,
        val structuralComponentId: Int?
) : Serializable