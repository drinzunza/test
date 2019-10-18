package com.uav_recon.app.api.entities.db

import java.io.Serializable
import javax.persistence.*

@Entity
@Table(name = "observation")
class Observation : Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    var id: Int = 0
    @Column(name = "code")
    var code: String? = null
    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "inspection_id", referencedColumnName = "id")
    var inspection: Inspection? = null
    @Column(name = "drawing_number")
    var drawingNumber: String? = null
    @Column(name = "room_number")
    var roomNumber: String? = null
    @Column(name = "span_number")
    var spanNumber: String? = null
    @Column(name = "location_description")
    var locationDescription: String? = null
    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "structural_component_id", referencedColumnName = "id")
    var structuralComponent: StructuralComponent? = null
    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "subcomponent_id", referencedColumnName = "id")
    var subcomponent: Subcomponent? = null
}