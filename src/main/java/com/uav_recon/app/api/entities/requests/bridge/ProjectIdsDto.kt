package com.uav_recon.app.api.entities.requests.bridge

import com.fasterxml.jackson.annotation.JsonInclude
import java.io.Serializable
import java.time.OffsetDateTime

@JsonInclude(JsonInclude.Include.NON_NULL)
class ProjectIdsDto(
        val id: Long = 0,
        val name: String,
        val structures: List<String>,
        val projectManagers: List<Long>,
        val createdAt: OffsetDateTime?,
        val updatedAt: OffsetDateTime?
) : Serializable