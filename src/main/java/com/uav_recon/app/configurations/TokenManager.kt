package com.uav_recon.app.configurations

import com.auth0.jwt.JWT
import com.auth0.jwt.algorithms.Algorithm
import org.springframework.beans.factory.annotation.Value
import org.springframework.stereotype.Component
import java.time.ZonedDateTime
import java.util.*

@Component
class TokenManager(
        @Value("\${token.secret}") private val secret: String,
        @Value("\${token.tokenExpirationTime}") private val tokenExpirationTime: Long) {
    private val algorithm: Algorithm = Algorithm.HMAC256(secret)
    private val userIdClaim = "userId"

    fun verifyAndExtractUserId(token: String): Long? {
        try {
            val verifier = JWT.require(algorithm).build()
            val jwt = verifier.verify(token)
            val userId = jwt.claims.get(userIdClaim) ?: return null
            return userId.asLong()
        } catch (ex: Exception) {
            ex.printStackTrace()
        }
        return null
    }

    fun generate(userId: Long): String {
        return JWT.create()
                .withExpiresAt(Date.from(ZonedDateTime.now().plusSeconds(tokenExpirationTime).toInstant()))
                .withClaim(userIdClaim, userId)
                .sign(algorithm)
    }
}
