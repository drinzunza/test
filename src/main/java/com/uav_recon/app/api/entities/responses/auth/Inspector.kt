package com.uav_recon.app.api.entities.responses.auth

import com.uav_recon.app.api.entities.requests.bridge.CompanyDto
import java.io.Serializable

data class Inspector(
        val id: String,
        val firstName: String,
        val lastName: String,
        val email: String,
        val position: String?,
        val company: CompanyDto?,
        val admin: Boolean
) : Serializable
