package com.uav_recon.app.api.entities.responses.auth

import java.io.Serializable

data class UserResponse(
        val token: String,
        val inspector: Inspector
) : Serializable
