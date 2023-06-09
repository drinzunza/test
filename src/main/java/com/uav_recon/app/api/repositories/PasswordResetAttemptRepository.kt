package com.uav_recon.app.api.repositories

import com.uav_recon.app.api.entities.db.PasswordResetAttempt
import org.springframework.data.jpa.repository.JpaRepository
import java.time.OffsetDateTime
import java.util.*

interface PasswordResetAttemptRepository : JpaRepository<PasswordResetAttempt, Long> {
    fun findByUserIdAndCreatedAtAfterAndUsedFalse(userId: Long, validCreatedAt: OffsetDateTime): Optional<PasswordResetAttempt>
}
