package com.uav_recon.app.api.entities.db

import java.io.Serializable
import javax.persistence.*

@Entity
@Table(name = "structure_component")
class StructureComponent : Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    var id: Int = 0
    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "structure_id", referencedColumnName = "id")
    var structure: Structure? = null
    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "structural_component_id", referencedColumnName = "id")
    var structuralComponent: StructuralComponent? = null
}