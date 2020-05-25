package com.uav_recon.app.api.entities.responses.bridge

import com.fasterxml.jackson.annotation.JsonInclude
import com.uav_recon.app.api.entities.db.ObservationType
import com.uav_recon.app.api.entities.db.StructuralType
import java.io.Serializable
import java.time.OffsetDateTime

@JsonInclude(JsonInclude.Include.NON_NULL)
data class ObservationDefectReportDto(
        val id: String,
        val type : StructuralType?,
        val defectName: String?,
        val locationId: String?,
        val stationMarker: String?,
        val clockPosition: Int?,
        val observationType: ObservationType?,
        val repairMethod: String?,
        val repairDate: OffsetDateTime?,
        val description: String?,
        val observationComponentName: String?,
        val observationSubcomponentName: String?,
        val observationDimensionNumber: Int?,
        val observationConditionRating1: Int?,
        val observationConditionRating2: Int?,
        val observationConditionRating3: Int?,
        val observationConditionRating4: Int?,
        val pictureLinks: List<String>,
        val inspectionId: String?,
        val inspectionDate: OffsetDateTime?,
        val structureId: String?,
        val structureName: String?,
        val projectName: String?,
        val projectId: Long?,
        val inspectorName: String?
) : Serializable