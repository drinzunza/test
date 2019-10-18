package com.uav_recon.app.api.entities.db

import java.io.Serializable
import javax.persistence.*

@Entity
@Table(name = "observation")
class Observation : Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    var id: Int = 0
    @Column(name = "inspection_id")
    var inspectionId: Int? = null
    @Column(name = "drawing_number")
    var drawingNumber: String? = null
    @Column(name = "room_number")
    var roomNumber: String? = null
    @Column(name = "span_number")
    var spanNumber: String? = null
    @Column(name = "location_description")
    var locationDescription: String? = null
    @Column(name = "structural_component_id")
    var structuralComponentId: Int? = null
    @Column(name = "subcomponent_id")
    var subcomponentId: String? = null
}