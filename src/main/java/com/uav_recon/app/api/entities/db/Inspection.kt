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
    @Column(name = "start_date")
    var startDate: Date? = null
    @Column(name = "end_date")
    var endDate: Date? = null
    @Column(name = "structure_id")
    var structureId: Int? = null
    @Column(name = "status")
    var status: String? = null
    @Column(name = "company_id")
    var companyId: Int? = null
    @Column(name = "inspector_id")
    var inspectorId: Int? = null
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