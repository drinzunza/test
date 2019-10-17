package com.uav_recon.app.api.entities.responses.auth

import java.io.Serializable

data class UserResponse(
        val firstName: String? = null,
        val lastName: String? = null,
        val email: String? = null,
        val appSession: String
) : Serializable