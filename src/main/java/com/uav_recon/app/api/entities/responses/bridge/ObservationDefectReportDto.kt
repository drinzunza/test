package com.uav_recon.app.api.entities.responses.bridge

import com.fasterxml.jackson.annotation.JsonInclude
import com.uav_recon.app.api.entities.db.ConditionType
import com.uav_recon.app.api.entities.db.ObservationType
import com.uav_recon.app.api.entities.db.StructuralType
import org.hibernate.cache.spi.support.AccessedDataClassification
import java.io.Serializable
import java.time.OffsetDateTime

@JsonInclude(JsonInclude.Include.NON_NULL)
data class ObservationDefectReportDto(
        val uuid: String,
        val id: String,
        val classification: StructuralType?,
        val locationId: String?,
        val stationMarker: String?,
        val clockPosition: Int?,
        val observationType: ObservationType?,
        val repairMethod: String?,
        val repairDate: String?,
        val description: String?,
        val summary: String?,
        val size: String?,
        val componentName: String?,
        val subcomponentName: String?,
        val dimensionNumber: Int?,
        val csRating: String?,
        val pictureLinks: List<String>,
        val inspectionId: String?,
        val inspectionDate: OffsetDateTime?,
        val structureId: String?,
        val structureName: String?,
        val structureCode: String?,
        val projectName: String?,
        val projectId: Long?,
        val inspectorName: String?,
        val previousDefectNumber: String?
) : Serializable