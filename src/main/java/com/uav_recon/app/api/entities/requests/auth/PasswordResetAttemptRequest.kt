package com.uav_recon.app.api.entities.requests.auth

import java.io.Serializable

data class PasswordResetAttemptRequest(
        val email: String,
        var code: Int?,
        var password: String?) : Serializable
