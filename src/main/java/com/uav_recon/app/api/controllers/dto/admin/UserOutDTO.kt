package com.uav_recon.app.api.controllers.dto.admin

import java.io.Serializable
import java.time.OffsetDateTime

data class UserOutDTO(
        var id: String = "",
        var email: String = "",
        var firstName: String = "",
        var lastName: String = "",
        var position: String? = null,
        var createdAt: OffsetDateTime = OffsetDateTime.now(),
        var admin: Boolean = false,
        var companyId: Long? = null

) : Serializable
