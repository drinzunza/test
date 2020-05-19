package com.uav_recon.app.api.entities.requests.bridge

import com.fasterxml.jackson.annotation.JsonInclude
import com.uav_recon.app.api.entities.db.Role
import java.io.Serializable

@JsonInclude(JsonInclude.Include.NON_NULL)
data class UserRolesDto(
        val id: Long,
        val roles: List<Role>
) : Serializable