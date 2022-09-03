package com.uav_recon.app.api.entities.requests.bridge

import com.fasterxml.jackson.annotation.JsonInclude
import java.io.Serializable
import java.time.OffsetDateTime

@JsonInclude(JsonInclude.Include.NON_NULL)
data class InspectionCloneDto (
        val existingInspectionUuid: String,
        val uuid: String,
        val inspectors: List<SimpleUserDto>?,
        val projectId: Long?,
        val startDate: OffsetDateTime?
) : Serializable