package com.uav_recon.app.api.entities.db

import java.io.Serializable
import javax.persistence.*

@Entity
@Table(name = "company_structure_types")
class CompanyStructureType(
        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        var id: Long = 0,
        @Column(name = "company_id")
        var companyId: Long,
        @Column(name = "structure_type_id")
        var structureTypeId: Long
) : Serializable