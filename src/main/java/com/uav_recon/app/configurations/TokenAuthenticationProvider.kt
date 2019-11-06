package com.uav_recon.app.configurations

import com.uav_recon.app.api.services.UserService
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.security.authentication.AuthenticationProvider
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken
import org.springframework.security.core.Authentication
import org.springframework.stereotype.Component
import java.util.*

@Component
class TokenAuthenticationProvider() : AuthenticationProvider {
    @Autowired
    lateinit var userService: UserService

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
