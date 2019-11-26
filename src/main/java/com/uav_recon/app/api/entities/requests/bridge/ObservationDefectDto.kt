package com.uav_recon.app.api.entities.requests.bridge

import com.fasterxml.jackson.annotation.JsonInclude
import com.uav_recon.app.api.entities.db.CriticalFinding
import java.io.Serializable

@JsonInclude(JsonInclude.Include.NON_NULL)
data class ObservationDefectDto(
        var id: String,
        val uuid: String,
        val criticalFindings: List<CriticalFinding>?,
        val defectId: String?,
        val conditionId: String?,
        val description: String?,
        val materialId: String?,
        val photos: List<PhotoDto>?,
        val spanNumber: Int?,
        val stationMarker: String?
) : Serializable
