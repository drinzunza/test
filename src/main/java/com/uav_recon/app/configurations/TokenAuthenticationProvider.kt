package com.uav_recon.app.configurations

import com.uav_recon.app.api.services.UserService
import org.springframework.security.authentication.AuthenticationProvider
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken
import org.springframework.security.core.Authentication
import java.util.*

class TokenAuthenticationProvider(private val userService: UserService) : AuthenticationProvider {

    override fun authenticate(authentication: Authentication?): Authentication? {
        Objects.requireNonNull(authentication, "No authentication data provided")
        if (authentication?.principal is Long) {
            val optional = userService.findById(authentication.principal as Long)
            if (optional.isPresent) {
                return UsernamePasswordAuthenticationToken(optional.get().email, null)
            }
        }
        return null
    }

    override fun supports(authentication: Class<*>): Boolean {
        return UsernamePasswordAuthenticationToken::class.java.isAssignableFrom(authentication)
    }
}
