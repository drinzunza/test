package com.uav_recon.app.api.entities.db

import java.io.Serializable
import javax.persistence.*

@Entity
@Table(name = "subcomponent")
class Subcomponent : Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    var id: Int = 0
    @Column(name = "name")
    var name: String? = null
    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "structural_component_id", referencedColumnName = "id")
    var structuralComponent: StructuralComponent? = null
}