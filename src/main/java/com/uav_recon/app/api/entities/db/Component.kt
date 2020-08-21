package com.uav_recon.app.api.entities.db

import java.io.Serializable
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.Id
import javax.persistence.Table

@Entity
@Table(name = "components")
class Component(
    @Id
    var id: String,
    var name: String,
    @Column(name = "structure_type_id")
    var structureTypeId: Long? = null,
    @Column(name = "company_id")
    var companyId: Long? = null,
    @Column(name = "is_deleted")
    var deleted: Boolean? = null
) : Serializable