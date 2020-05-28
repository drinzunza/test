package com.uav_recon.app.api.entities.db

import java.io.Serializable
import javax.persistence.*

@Entity
@Table(name = "components")
class Component(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    var id: String,
    var name: String,
    var type: StructureComponentType? = null,
    @Column(name = "company_id")
    var companyId: Long? = null,
    @Column(name = "is_deleted")
    val deleted: Boolean? = null
) : Serializable