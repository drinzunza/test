package com.uav_recon.app.api.entities.responses.bridge

import java.io.Serializable

data class ObservationResponse(
        val id: Int,
        val code: String?,
        val inspectionId: Int?,
        val drawingNumber: String?,
        val roomNumber: String?,
        val spanNumber: String?,
        val locationDescription: String?,
        val structuralComponentId: Int?,
        val subcomponentId: Int?
) : Serializable