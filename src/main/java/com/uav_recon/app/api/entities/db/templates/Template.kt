package com.uav_recon.app.api.entities.db.templates

import java.io.Serializable
import javax.persistence.*

@Entity
@Table(name = "templates")
class Template(
        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        var id: Long = 0,
        var name: String,
        @Column(name = "structure_type_id")
        var structureTypeId: Long,
        @Column(name = "company_id")
        var companyId: Long,
        @Column(name = "is_deleted")
        var deleted: Boolean = false
) : Serializable