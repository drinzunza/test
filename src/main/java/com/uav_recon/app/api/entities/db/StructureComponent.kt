package com.uav_recon.app.api.entities.db

import java.io.Serializable
import javax.persistence.*

@Entity
@Table(name = "structure_components")
class StructureComponent(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    var id: Int = 0,
    @Column(name = "subcomponent_id")
    var structureId: Int? = null,
    @Column(name = "structural_component_id")
    var structuralComponentId: Int? = null
) : Serializable