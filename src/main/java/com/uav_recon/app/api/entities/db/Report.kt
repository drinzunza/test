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
    @Temporal(TemporalType.DATE)
    @Column(name = "date")
    var date: Date? = null
    @Column(name = "file")
    var file: String? = null
    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "inspection_id", referencedColumnName = "id")
    var inspection: Inspection? = null
}