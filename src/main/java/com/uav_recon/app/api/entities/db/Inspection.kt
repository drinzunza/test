package com.uav_recon.app.api.entities.db

import java.io.Serializable
import java.util.*
import javax.persistence.*

@Entity
@Table(name = "inspection")
class Inspection : Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    var id: Int = 0
    @Temporal(TemporalType.DATE)
    @Column(name = "start_date")
    var startDate: Date? = null
    @Temporal(TemporalType.DATE)
    @Column(name = "end_date")
    var endDate: Date? = null
    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "structure_id", referencedColumnName = "id")
    var structure: Structure? = null
    @Column(name = "status")
    var status: String? = null
    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "company_id", referencedColumnName = "id")
    var company: Company? = null
    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "inspector_id", referencedColumnName = "id")
    var inspector: Inspector? = null
    @Column(name = "general_summary")
    var generalSummary: String? = null
    @Column(name = "term_rating")
    var termRating: String? = null
    @Column(name = "sgr_rating")
    var sgrRating: String? = null
    @Column(name = "temperature")
    var temperature: Double? = null
    @Column(name = "humidity")
    var humidity: Double? = null
    @Column(name = "wind")
    var wind: Double? = null
}