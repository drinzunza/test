package com.uav_recon.app.api.entities.requests.bridge

import com.fasterxml.jackson.annotation.JsonInclude
import com.uav_recon.app.api.entities.db.CriticalFinding
import com.uav_recon.app.api.entities.db.ObservationType
import com.uav_recon.app.api.entities.db.StructuralType
import java.io.Serializable
import java.time.OffsetDateTime

@JsonInclude(JsonInclude.Include.NON_NULL)
data class ObservationDefectDto(
        var id: String,
        val uuid: String,
        val createdBy: SimpleUserDto?,
        val criticalFindings: List<CriticalFinding>?,
        val defectId: String?,
        val conditionId: String?,
        val description: String?,
        val materialId: String?,
        val photos: List<PhotoDto>?,
        val span: String?,
        val stationMarker: String?,
        val observationType: ObservationType?,
        val size: String?,
        val type: StructuralType?,
        val weather: Weather?,
        val observationNameId: String?,
        val clockPosition: Int?,
        val repairDate: String?,
        val repairMethod: String?,
        val previousDefectNumber: String?,
        var createdAt: OffsetDateTime?,
        var createdAtClient: OffsetDateTime?
) : Serializable
