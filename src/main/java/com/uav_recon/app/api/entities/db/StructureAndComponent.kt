package com.uav_recon.app.api.entities.db

import java.io.Serializable
import javax.persistence.*

@Entity
@Table(name = "structure_and_component")
class StructureAndComponent : Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    var id: Int = 0
    @Column(name = "structure_id")
    var structureId: Int? = null
    @Column(name = "component_id")
    var componentId: Int? = null
}