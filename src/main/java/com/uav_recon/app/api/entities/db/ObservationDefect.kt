package com.uav_recon.app.api.entities.db

import com.uav_recon.app.api.entities.requests.bridge.ObservationDefectUpdateDto
import com.vladmihalcea.hibernate.type.array.EnumArrayType
import org.hibernate.annotations.Parameter
import org.hibernate.annotations.Type
import org.hibernate.annotations.TypeDef
import java.time.OffsetDateTime
import java.util.*
import javax.persistence.*

@Entity
@Table(name = "observation_defects")
@TypeDef(
    typeClass = EnumArrayType::class,
    defaultForType = Array<CriticalFinding>::class,
    parameters = [
        Parameter(
            name = EnumArrayType.SQL_ARRAY_TYPE,
            value = "critical_finding"
        )
    ]
)
class ObservationDefect(
        uuid: String,
        var id: String,
        createdBy: Int,
        updatedBy: Int,
        @Column(name = "observation_id")
        var observationId: String,
        @Column(name = "defect_id")
        var defectId: String? = null,
        @Column(name = "condition_id")
        var conditionId: String? = null,
        var description: String? = null,
        @Column(name = "material_id")
        var materialId: String? = null,
        @Column(name = "critical_findings", columnDefinition = "critical_finding[]")
        var criticalFindings: Array<CriticalFinding>?,
        @Column(name = "span")
        var span: String? = null,
        @Column(name = "station_marker")
        var stationMarker: String?,
        @Column(name = "is_deleted")
        var deleted: Boolean? = false,
        @Column(name = "observation_type")
        @Enumerated(EnumType.STRING)
        @Type(type = "pgsql_enum")
        var observationType: ObservationType? = null,
        var size: String? = null,
        @Enumerated(EnumType.STRING)
        @Type(type = "pgsql_enum")
        var type: StructuralType? = null,
        var temperature: Double? = null,
        var humidity: Double? = null,
        var wind: Double? = null,
        @Column(name = "observation_name_id")
        var observationNameId: String? = null,
        @Column(name = "clock_position")
        var clockPosition: Int? = null,
        @Column(name = "repair_date")
        var repairDate: String? = null,
        @Column(name = "repair_method")
        var repairMethod: String? = null,
        @Column(name = "previous_defect_number")
        var previousDefectNumber: String? = null,
        @Column(name = "created_at_client")
        var createdAtClient: OffsetDateTime? = null,
        @Transient
        var defect: Defect? = null,
        @Transient
        var condition: Condition? = null,
        @Transient
        var observationName: ObservationName? = null,
        @Transient
        var photos: List<Photo>? = null
) : MobileAppCreatedEntity(uuid, createdBy, updatedBy)

fun ObservationDefect.update(dto: ObservationDefectUpdateDto): ObservationDefect {
        if (dto.fields.contains(::id.name)) id = dto.id
        if (dto.fields.contains(::criticalFindings.name)) criticalFindings = dto.criticalFindings?.toTypedArray()
        if (dto.fields.contains(::defectId.name)) defectId = dto.defectId
        if (dto.fields.contains(::conditionId.name)) conditionId = dto.conditionId
        if (dto.fields.contains(::description.name)) description = dto.description
        if (dto.fields.contains(::span.name)) span = dto.span
        if (dto.fields.contains(::stationMarker.name)) stationMarker = dto.stationMarker
        if (dto.fields.contains(::observationType.name)) observationType = dto.observationType
        if (dto.fields.contains(::size.name)) size = dto.size
        if (dto.fields.contains(::type.name)) type = dto.type
        if (dto.fields.contains(::observationNameId.name)) observationNameId = dto.observationNameId
        if (dto.fields.contains(::clockPosition.name)) clockPosition = dto.clockPosition
        if (dto.fields.contains(::repairDate.name)) repairDate = dto.repairDate
        if (dto.fields.contains(::repairMethod.name)) repairMethod = dto.repairMethod
        if (dto.fields.contains(::previousDefectNumber.name)) previousDefectNumber = dto.previousDefectNumber
        return this
}