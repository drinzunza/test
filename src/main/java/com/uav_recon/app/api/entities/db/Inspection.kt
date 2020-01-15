package com.uav_recon.app.api.entities.db

import org.hibernate.annotations.Type
import java.time.OffsetDateTime
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.EnumType
import javax.persistence.Enumerated
import javax.persistence.Table
import javax.persistence.Transient

@Entity
@Table(name = "inspections")
class Inspection(
        uuid: String,
        createdBy: Int,
        updatedBy: Int,
        @Column(name = "is_editable")
        var isEditable: Boolean? = true,
        @Column(name = "start_date")
        var startDate: OffsetDateTime? = null,
        @Column(name = "end_date")
        var endDate: OffsetDateTime? = null,
        @Column(name = "structure_id")
        var structureId: String? = null,
        var temperature: Double? = null,
        var humidity: Double? = null,
        var wind: Double? = null,
        var latitude: Double? = null,
        var longitude: Double? = null,
        var altitude: Double? = null,
        @Enumerated(EnumType.STRING)
        @Type(type = "pgsql_enum")
        var status: InspectionStatus? = null,
        @Column(name = "report_id")
        var reportId: String? = null,
        @Column(name = "report_date")
        var reportDate: OffsetDateTime? = null,
        @Column(name = "report_link")
        var reportLink: String? = null,
        @Column(name = "general_summary")
        var generalSummary: String? = null,
        @Column(name = "sgr_rating")
        var sgrRating: String? = null,
        @Enumerated(EnumType.STRING)
        @Column(name = "term_rating")
        @Type(type = "pgsql_enum")
        var termRating: InspectionTermRating? = null,
        @Column(name = "spans_count")
        var spansCount: Int? = 0,
        @Column(name = "is_deleted")
        var deleted: Boolean? = false
) : MobileAppCreatedEntity(uuid, createdBy, updatedBy)
