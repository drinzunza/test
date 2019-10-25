package com.uav_recon.app.api.entities.responses.bridge

import java.io.Serializable

data class StructureComponentResponse(
        val id: Int,
        val structureId: Int?,
        val structuralComponentId: Int?
) : Serializable