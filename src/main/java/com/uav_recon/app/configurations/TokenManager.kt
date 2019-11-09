package com.uav_recon.app.configurations

import com.auth0.jwt.JWT
import com.auth0.jwt.algorithms.Algorithm
import org.springframework.stereotype.Component
import java.time.ZonedDateTime
import java.util.*

@Component
class TokenManager(private val configuration: UavConfiguration) {
    private val tokenExpirationTime = configuration.token.tokenExpirationTime.toLong()
    private val algorithm: Algorithm = Algorithm.HMAC256(configuration.token.secret)
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
        val expiresAt = Date.from(ZonedDateTime.now().plusSeconds(tokenExpirationTime).toInstant())
        return JWT.create()
                .withExpiresAt(expiresAt)
                .withClaim(userIdClaim, userId)
                .sign(algorithm)
    }
}
