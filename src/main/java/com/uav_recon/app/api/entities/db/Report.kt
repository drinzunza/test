package com.uav_recon.app.api.entities.db

import java.io.Serializable
import java.util.*
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.FetchType
import javax.persistence.GeneratedValue
import javax.persistence.GenerationType
import javax.persistence.Id
import javax.persistence.JoinColumn
import javax.persistence.OneToOne
import javax.persistence.Table
import javax.persistence.Temporal
import javax.persistence.TemporalType

@Entity
@Table(name = "report")
class Report : Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    var id: Int = 0
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "date")
    var date: Date? = null
    @Column(name = "file")
    var file: String? = null
    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "inspection_id", referencedColumnName = "uuid")
    var inspection: Inspection? = null
}
