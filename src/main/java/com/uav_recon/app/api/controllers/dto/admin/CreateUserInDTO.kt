package com.uav_recon.app.api.controllers.dto.admin

import java.io.Serializable

data class CreateUserInDTO(
        var email: String = "",
        var password: String = "",
        var firstName: String = "",
        var lastName: String = "",
        var position: String? = "",
        var admin: Boolean = false,
        var companyId: Long? = null
) : Serializable
