package com.uav_recon.app.api.entities.requests.bridge

import com.fasterxml.jackson.annotation.JsonInclude
import java.io.Serializable
import java.time.OffsetDateTime

@JsonInclude(JsonInclude.Include.NON_NULL)
class ProjectDto(
        val id: Long = 0,
        val name: String,
        val company: CompanyDto?,
        val structures: List<SimpleStructureDto>,
        val projectManagers: List<SimpleUserDto>,
        val createdAt: OffsetDateTime?,
        val updatedAt: OffsetDateTime?
) : Serializable