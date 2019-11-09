package com.uav_recon.app.api.entities.requests.bridge

import java.io.Serializable

data class ObservationDefectDto(
        val id: String,
        val uuid: String,
        val criticalFindings: List<CriticalFinding>,
        val defectId: Int?,
        val conditionId: Int?,
        val description: String?,
        val materialId: Int?,
        val photos: List<Photo>?
) : Serializable
