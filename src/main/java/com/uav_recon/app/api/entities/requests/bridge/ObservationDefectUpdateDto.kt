package com.uav_recon.app.api.entities.requests.bridge

import com.fasterxml.jackson.annotation.JsonInclude
import com.uav_recon.app.api.entities.db.CriticalFinding
import com.uav_recon.app.api.entities.db.InspectionStatus
import com.uav_recon.app.api.entities.db.ObservationType
import com.uav_recon.app.api.entities.db.StructuralType
import java.io.Serializable
import java.time.OffsetDateTime

@JsonInclude(JsonInclude.Include.NON_NULL)
data class ObservationDefectUpdateDto(
        var id: String?,
        val criticalFindings: List<CriticalFinding>?,
        val defectId: String?,
        val conditionId: String?,
        val description: String?,
        val span: String?,
        val stationMarker: String?,
        val observationType: ObservationType?,
        val size: String?,
        val type: StructuralType?,
        val observationNameId: String?,
        val clockPosition: Int?,
        val repairDate: String?,
        val repairMethod: String?,
        val previousDefectNumber: String?,
        val fields: List<String>
) : Serializable