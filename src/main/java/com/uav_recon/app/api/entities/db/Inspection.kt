package com.uav_recon.app.api.entities.db

import com.uav_recon.app.api.entities.requests.bridge.InspectionUpdateDto
import org.hibernate.annotations.Type
import java.time.OffsetDateTime
import javax.persistence.*

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
        @Column(name = "term_rating")
        var termRating: Double? = null,
        @Column(name = "spans_count")
        var spansCount: Int? = 0,
        @Column(name = "is_deleted")
        var deleted: Boolean? = false,
        @Column(name = "project_id")
        var projectId: Long? = null,
        @Column(name = "is_archived")
        var archived: Boolean? = false,
        @Column(name = "previous_inspection_id")
        var previousInspectionId: String? = null,
        @Transient
        var observations: List<Observation>? = null,
        @Transient
        var structureSubdivisions: List<StructureSubdivision>? = null
) : MobileAppCreatedEntity(uuid, createdBy, updatedBy) {
        override fun toString(): String {
                return "Inspection(isEditable=$isEditable, startDate=$startDate, endDate=$endDate, structureId=$structureId, temperature=$temperature, humidity=$humidity, wind=$wind, latitude=$latitude, longitude=$longitude, altitude=$altitude, status=$status, reportId=$reportId, reportDate=$reportDate, reportLink=$reportLink, generalSummary=$generalSummary, sgrRating=$sgrRating, termRating=$termRating, spansCount=$spansCount, deleted=$deleted, projectId=$projectId, archived=$archived, observations=$observations)"
        }
}

fun Inspection.inspectionDate(): OffsetDateTime? {
    var minDate: OffsetDateTime? = null
    observations?.forEach {
        val date = it.defects?.mapNotNull { it.createdAtClient }?.minBy { it.toEpochSecond() }
        if (minDate?.toEpochSecond() ?: 0 > date?.toEpochSecond() ?: 0) {
            minDate = date
        }
    }
    return minDate ?: startDate
}

fun Inspection.update(dto: InspectionUpdateDto): Inspection {
        if (dto.fields.contains(::isEditable.name)) isEditable = dto.isEditable
        if (dto.fields.contains(::startDate.name)) startDate = dto.startDate
        if (dto.fields.contains(::endDate.name)) endDate = dto.endDate
        if (dto.fields.contains(::structureId.name)) structureId = dto.structureId
        if (dto.fields.contains(::latitude.name)) latitude = dto.location?.latitude
        if (dto.fields.contains(::longitude.name)) longitude = dto.location?.longitude
        if (dto.fields.contains(::altitude.name)) altitude = dto.location?.altitude
        if (dto.fields.contains(::status.name)) status = dto.status
        if (dto.fields.contains(::generalSummary.name)) generalSummary = dto.generalSummary
        if (dto.fields.contains(::sgrRating.name)) sgrRating = dto.sgrRating
        if (dto.fields.contains(::termRating.name)) termRating = dto.termRating
        if (dto.fields.contains(::spansCount.name)) spansCount = dto.spansCount
        if (dto.fields.contains(::projectId.name)) projectId = dto.projectId
        if (dto.fields.contains(::archived.name)) archived = dto.archived
        return this
}
