package com.uav_recon.app.api.entities.db

import java.io.Serializable
import javax.persistence.*

@Entity
@Table(name = "material")
class Material : Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    var id: Int = 0
    @Column(name = "name")
    var name: String? = null
    @Column(name = "description")
    var description: String? = null
    @Column(name = "measure_unit")
    var measureUnit: String? = null
    @Column(name = "subcomponent_id")
    var subcomponentId: String? = null
}