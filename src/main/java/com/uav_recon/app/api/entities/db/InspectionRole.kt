package com.uav_recon.app.api.entities.db

import com.vladmihalcea.hibernate.type.array.EnumArrayType
import org.hibernate.annotations.Parameter
import org.hibernate.annotations.TypeDef
import java.io.Serializable
import javax.persistence.*

@Entity
@Table(name = "inspection_roles")
@TypeDef(
        typeClass = EnumArrayType::class,
        defaultForType = Array<Role>::class,
        parameters = [
            Parameter(
                    name = EnumArrayType.SQL_ARRAY_TYPE,
                    value = "user_role"
            )
        ]
)
class InspectionRole(
        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        val id: Long = 0,
        @Column(name = "inspection_id")
        val inspectionId: String,
        @Column(name = "user_id")
        val userId: Long,
        @Column(name = "roles", columnDefinition = "user_role[]")
        var roles: Array<Role>?
) : Serializable