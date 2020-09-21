package com.uav_recon.app.api.entities.requests.bridge

import com.fasterxml.jackson.annotation.JsonInclude
import com.uav_recon.app.api.entities.db.User
import java.io.Serializable

@JsonInclude(JsonInclude.Include.NON_NULL)
data class SimpleUserDto(
        val id: Long,
        val email: String,
        val firstName: String,
        val lastName: String
) : Serializable {

    constructor(user: User) : this(user.id, user.email, user.firstName, user.lastName)

}

fun User.toDto() = SimpleUserDto(
        id = id,
        firstName = firstName,
        lastName = lastName,
        email = email
)
