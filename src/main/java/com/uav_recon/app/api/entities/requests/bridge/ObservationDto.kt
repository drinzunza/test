package com.uav_recon.app.api.entities.requests.bridge

import com.fasterxml.jackson.annotation.JsonInclude
import java.io.Serializable

@JsonInclude(JsonInclude.Include.NON_NULL)
data class ObservationDto(
        val id: String,
        val uuid: String,
        val observationDefects: List<ObservationDefectDto>?,
        val structuralComponentId: String?,
        val subComponentId: String?,
        val drawingNumber: String?,
        val roomNumber: String?,
        val dimensionNumber: Int?,
        val locationDescription: String?,
        val inspected: Boolean?
) : Serializable
