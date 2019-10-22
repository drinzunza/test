package com.uav_recon.app.api.entities.db

import java.io.Serializable
import java.util.*
import javax.persistence.*

@Entity
@Table(name = "photo")
class Photo : Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    var id: Int = 0
    @Column(name = "file")
    var file: String? = null
    @Column(name = "latitude")
    var latitude: Double? = null
    @Column(name = "longitude")
    var longitude: Double? = null
    @Column(name = "altitude")
    var altitude: Double? = null
    @Column(name = "start_x")
    var startX: Double? = null
    @Column(name = "start_y")
    var startY: Double? = null
    @Column(name = "end_x")
    var endX: Double? = null
    @Column(name = "end_y")
    var endY: Double? = null
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "created_date")
    var createdDate: Date? = null
    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "observation_defect_id", referencedColumnName = "id")
    var observationDefect: ObservationDefect? = null
}