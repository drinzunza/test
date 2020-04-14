package com.uav_recon.app.api.entities.db

import java.time.OffsetDateTime
import javax.persistence.*

@Entity
@Table(name = "users")
class User(
        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        var id: Long? = null,
        val email: String,
        var password: String,
        @Column(name = "first_name")
        val firstName: String,
        @Column(name = "last_name")
        val lastName: String,
        var position: String?,
        @Column(name = "created_at")
        val createdAt: OffsetDateTime = OffsetDateTime.now(),
        @Column(name = "company_id")
        val companyId: Long? = null
)
