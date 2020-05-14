package com.uav_recon.app.api.controllers.dto.admin

import java.io.Serializable

data class UserOutDTO(
        var id: String,
        var email: String,
        var firstName: String,
        var lastName: String,
        var position: String?,
        var createdAt: String,
        var admin: Boolean,
        var companyId: Long?

) : Serializable {
    constructor() : this("", "", "", "", "", "", false, null)
}
