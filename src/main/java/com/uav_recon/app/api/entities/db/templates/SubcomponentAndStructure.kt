package com.uav_recon.app.api.entities.db.templates

import java.io.Serializable
import javax.persistence.*

@Entity
@Table(name = "sub_component_and_structures")
class SubcomponentAndStructure(
        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        var id: Long = 0,
        @Column(name = "sub_component_id")
        var subcomponentId: String,
        @Column(name = "structure_id")
        var structureId: String,
        var size: Int? = 0
) : Serializable
