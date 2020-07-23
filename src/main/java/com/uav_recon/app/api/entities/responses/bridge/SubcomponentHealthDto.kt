package com.uav_recon.app.api.entities.responses.bridge

import com.fasterxml.jackson.annotation.JsonInclude
import java.io.Serializable
import java.time.OffsetDateTime

@JsonInclude(JsonInclude.Include.NON_NULL)
data class SubcomponentHealthDto(
        val id: String?,
        val structureId: String?,
        val structureName: String?,
        val structureCode: String?,
        val subcomponentName: String?,
        val componentName: String?,
        val inspectionId: String?,
        val inspectionDate: OffsetDateTime?,
        val conditionRating1: Int?,
        val conditionRating2: Int?,
        val conditionRating3: Int?,
        val conditionRating4: Int?,
        val subcomponentHealthIndex: Double?,
        val componentHealthIndex: Double?
) : Serializable