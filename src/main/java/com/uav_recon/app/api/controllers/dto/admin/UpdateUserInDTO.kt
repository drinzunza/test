package com.uav_recon.app.api.controllers.dto.admin

import java.io.Serializable

data class UpdateUserInDTO(
        var email: String? = null,
        var firstName: String? = null,
        var lastName: String? = null,
        var position: String? = null,
        var admin: Boolean? = null,
        var companyId: Long? = null
) : Serializable
