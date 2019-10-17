package com.uav_recon.app.api.entities.requests.auth

import java.io.Serializable

data class AuthorizationRequest(
        val email: String,
        val password: String
) : Serializable