package com.uav_recon.app.api.entities.db

import java.time.OffsetDateTime
import javax.persistence.*

@Entity
@Table(name = "password_reset_attempts")
class PasswordResetAttempt(
        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        var id: Long? = null,
        @Column(name = "user_id")
        val userId: Long,
        val code: Int,
        var used: Boolean = false,
        @Column(name = "created_at")
        val createdAt: OffsetDateTime = OffsetDateTime.now())
