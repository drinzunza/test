package com.uav_recon.app.api.entities.db.templates

import java.io.Serializable
import javax.persistence.*

@Entity
@Table(name = "sub_component_inspections")
class SubcomponentInspection(
        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        var id: Long = 0,
        @Column(name = "sub_component_and_structure_id")
        var subcomponentAndStructureId: Long,
        @Column(name = "inspection_id")
        var inspectionId: String,
        @Column(name = "is_checked")
        var checked: Boolean = true
) : Serializable