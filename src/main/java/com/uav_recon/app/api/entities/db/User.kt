package com.uav_recon.app.api.entities.db

import org.hibernate.annotations.ResultCheckStyle
import org.hibernate.annotations.SQLDelete
import org.hibernate.annotations.Where
import java.time.OffsetDateTime
import javax.persistence.*

@Entity
@Table(name = "users")
@SQLDelete(sql = "UPDATE \"users\" SET deleted_at = NOW() WHERE id = ?", check = ResultCheckStyle.COUNT)
@Where(clause = "deleted_at IS NULL")
class User(
        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        var id: Long = 0,
        var email: String,
        var password: String,
        @Column(name = "first_name")
        var firstName: String,
        @Column(name = "last_name")
        var lastName: String,
        var position: String?,
        @Column(name = "created_at")
        val createdAt: OffsetDateTime = OffsetDateTime.now(),
        @Column(name = "company_id")
        var companyId: Long? = null,
        var admin: Boolean = false
) {
    constructor() : this(0, "", "", "", "", "", OffsetDateTime.now(), null)
}
