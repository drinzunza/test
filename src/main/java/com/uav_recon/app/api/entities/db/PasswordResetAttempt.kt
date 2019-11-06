package com.uav_recon.app.api.entities.db

import java.time.LocalDateTime
import javax.persistence.*

@Entity
@Table(name = "password_reset_attempts")
class PasswordResetAttempt(
        @Id
        @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "password_reset_attempts_id_seq")
        var id: Long? = null,
        @Column(name = "user_id")
        val userId: Long,
        val code: Int,
        var used: Boolean = false,
        @Column(name = "created_at")
        val createdAt: LocalDateTime = LocalDateTime.now())
