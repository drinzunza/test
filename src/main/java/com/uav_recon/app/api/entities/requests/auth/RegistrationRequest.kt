package com.uav_recon.app.api.entities.requests.auth

import java.io.Serializable

data class RegistrationRequest(
        val email: String,
        val password: String,
        val firstName: String,
        val lastName: String,
        val position: String?
) : Serializable
