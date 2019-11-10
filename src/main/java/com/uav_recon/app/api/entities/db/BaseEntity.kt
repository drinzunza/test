package com.uav_recon.app.api.entities.db

import com.vladmihalcea.hibernate.type.basic.PostgreSQLEnumType
import org.hibernate.annotations.TypeDef
import java.io.Serializable
import java.time.OffsetDateTime
import javax.persistence.Column
import javax.persistence.MappedSuperclass

@MappedSuperclass
@TypeDef(name = "pgsql_enum", typeClass = PostgreSQLEnumType::class)
abstract class BaseEntity : Serializable {
    @Column(name = "created_at")
    var createdAt: OffsetDateTime? = OffsetDateTime.now()
    @Column(name = "updated_at")
    var updatedAt: OffsetDateTime? = OffsetDateTime.now()
}
