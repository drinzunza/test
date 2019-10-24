package com.uav_recon.app.api.entities.requests.bridge

import java.io.Serializable

data class ObservationDefectRequest(
    val defectId: Int?,
    val conditionId: Int?,
    val observationId: Int?,
    val description: String?,
    val materialId: Int?,
    val criticalFindings: String?,
    val size: String?
) : Serializable