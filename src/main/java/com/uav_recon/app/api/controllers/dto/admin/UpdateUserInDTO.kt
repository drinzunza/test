package com.uav_recon.app.api.controllers.dto.admin

import java.io.Serializable

data class UpdateUserInDTO(
        val email: String,
        val firstName: String,
        val lastName: String,
        val position: String?,
        val admin: Boolean,
        val companyId: Long?
) : Serializable {
    constructor() : this("","", "", null, false, null)
}
