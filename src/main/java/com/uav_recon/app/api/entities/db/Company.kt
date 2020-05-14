package com.uav_recon.app.api.entities.db

import java.io.Serializable
import java.time.OffsetDateTime
import javax.persistence.*

@Entity
@Table(name = "companies")
class Company(
        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        var id: Long = 0,
        var name: String,
        var logo: String?,
        @Column(name = "is_deleted")
        var deleted: Boolean = false,
        @Column(name = "created_by")
        val createdBy: Long,
        @Column(name = "updated_by")
        var updatedBy: Long,
        @Column(name = "created_at")
        val createdAt: OffsetDateTime? = OffsetDateTime.now(),
        @Column(name = "updated_at")
        val updatedAt: OffsetDateTime? = OffsetDateTime.now()
) : Serializable
