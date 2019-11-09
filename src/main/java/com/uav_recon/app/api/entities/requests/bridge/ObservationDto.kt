package com.uav_recon.app.api.entities.requests.bridge

import java.io.Serializable

data class ObservationDto(
        val id: String,
        val uuid: String,
        val observationDefects: List<ObservationDefectDto>,
        val structuralComponentId: Int?,
        val subComponentId: Int?,
        val drawingNumber: String?,
        val roomNumber: String?,
        val spanNumber: String?,
        val locationDescription: String?
) : Serializable
