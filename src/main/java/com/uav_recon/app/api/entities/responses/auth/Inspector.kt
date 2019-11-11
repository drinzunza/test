package com.uav_recon.app.api.entities.responses.auth

import java.io.Serializable

data class Inspector(val id: String,
                     val firstName: String,
                     val lastName: String,
                     val email: String,
                     val position: String?) : Serializable
