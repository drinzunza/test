package com.uav_recon.app.api.entities.requests.bridge

import com.fasterxml.jackson.annotation.JsonInclude
import com.uav_recon.app.api.entities.db.StructureSubdivision
import java.io.Serializable

@JsonInclude(JsonInclude.Include.NON_NULL)
data class StructureSubdivisionDto(
        val uuid: String,
        var inspectionId: String,
        val name: String?,
        val number: String?,
        val sgrRating: String?,
        val computedSgrRating: Double?,
        var observationStructureSubdivisions: List<ObservationStructureSubdivisionDto>? = null
) : Serializable

fun StructureSubdivisionDto.toEntity() = StructureSubdivision(
        uuid = uuid,
        inspectionId = inspectionId,
        name = name,
        number = number,
        sgrRating = sgrRating
)