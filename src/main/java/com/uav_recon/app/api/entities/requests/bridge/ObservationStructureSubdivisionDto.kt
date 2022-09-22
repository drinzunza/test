package com.uav_recon.app.api.entities.requests.bridge

import com.fasterxml.jackson.annotation.JsonInclude
import com.uav_recon.app.api.entities.db.ObservationStructureSubdivision
import java.io.Serializable

@JsonInclude(JsonInclude.Include.NON_NULL)
data class ObservationStructureSubdivisionDto(
    val uuid: String,
    val structureSubdivisionId: String,
    val observationId: String,
    val dimensionNumber: Int
) : Serializable

fun ObservationStructureSubdivisionDto.toEntity() = ObservationStructureSubdivision(
    uuid = uuid,
    structureSubdivisionId = structureSubdivisionId,
    observationId = observationId,
    dimensionNumber = dimensionNumber
)