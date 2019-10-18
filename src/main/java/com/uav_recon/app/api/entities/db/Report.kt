package com.uav_recon.app.api.entities.db

import java.io.Serializable
import java.util.*
import javax.persistence.*

@Entity
@Table(name = "report")
class Report : Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    var id: Int = 0
    @Column(name = "date")
    var date: Date? = null
    @Column(name = "file")
    var file: String? = null
    @Column(name = "inspection_id")
    var inspectionId: Int? = null
}