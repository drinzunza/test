package com.uav_recon.app.api.entities.requests.bridge

import com.fasterxml.jackson.annotation.JsonInclude
import com.uav_recon.app.api.entities.db.*
import java.io.Serializable

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
        val clockPosition: String?,
        val repairDate: String?,
        val repairMethod: String?,
        val previousDefectNumber: String?,
        val status: ObservationDefectStatus?,
        val done: Boolean?,
        val structureSubdivisionId: String?,
        val fields: List<String>
) : Serializable
