package com.uav_recon.app.api.entities.db

import java.io.Serializable
import javax.persistence.*

@Entity
@Table(name = "defect")
class Defect : Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    var id: Int = 0
    @Column(name = "name")
    var name: String? = null
    @Column(name = "number")
    var number: Int? = null
    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "material_id", referencedColumnName = "id")
    var material: Material? = null
}