package com.uav_recon.app.api.controllers.dto.admin

import java.io.Serializable

data class UserOutDTO(
        val id: String,
        val email: String,
        val firstName: String,
        val lastName: String,
        val position: String?,
        val createdAt: String,
        val companyId: Number?

) : Serializable {
    constructor() : this("", "", "", "", "", "", null)
}
