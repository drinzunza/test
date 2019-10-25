package com.uav_recon.app.api.entities.responses.bridge

import java.io.Serializable

data class ObservationDefectResponse(
        val id: Int,
        val defectId: Int?,
        val conditionId: Int?,
        val observationId: Int?,
        val description: String?,
        val materialId: Int?,
        val criticalFindings: String?,
        val size: String?
) : Serializable