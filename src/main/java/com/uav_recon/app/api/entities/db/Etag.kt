package com.uav_recon.app.api.entities.db

import java.io.Serializable
import java.time.OffsetDateTime
import javax.persistence.*

@Entity
@Table(name = "etags")
class Etag(
        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        val id: Int,
        val hash: String,
        val change: String? = null,
        @Column(name = "created_at")
        val createdAt: OffsetDateTime = OffsetDateTime.now(),
        @Column(name = "company_id")
        val companyId: Long? = null
) : Serializable