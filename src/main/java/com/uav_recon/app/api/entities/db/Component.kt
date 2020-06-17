package com.uav_recon.app.api.entities.db

import org.hibernate.annotations.Type
import java.io.Serializable
import javax.persistence.*

@Entity
@Table(name = "components")
class Component(
    @Id
    var id: String,
    var name: String,
    @Enumerated(EnumType.STRING)
    @Type(type = "pgsql_enum")
    var type: StructureComponentType? = null,
    @Column(name = "company_id")
    var companyId: Long? = null,
    @Column(name = "is_deleted")
    var deleted: Boolean? = null
) : Serializable