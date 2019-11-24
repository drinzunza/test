package com.uav_recon.app.api.entities.db

import java.io.Serializable
import javax.persistence.*

@Entity
@Table(name = "defects")
class Defect(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    var id: Int = 0,
    @Column(name = "name")
    var name: String? = null,
    @Column(name = "number")
    var number: Int? = null,
    @Column(name = "material_id")
    var materialId: Int? = null
) : Serializable