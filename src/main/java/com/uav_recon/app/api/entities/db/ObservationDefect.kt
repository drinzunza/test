package com.uav_recon.app.api.entities.db

import com.vladmihalcea.hibernate.type.array.EnumArrayType
import org.hibernate.annotations.Parameter
import org.hibernate.annotations.Type
import org.hibernate.annotations.TypeDef
import java.time.OffsetDateTime
import java.util.*
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.EnumType
import javax.persistence.Enumerated
import javax.persistence.Table
import javax.persistence.Transient

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
        val observationNameId: String? = null,
        @Column(name = "clock_position")
        val clockPosition: Int? = null,
        @Column(name = "repair_date")
        val repairDate: String? = null,
        @Column(name = "repair_method")
        val repairMethod: String? = null,
        @Column(name = "previous_defect_number")
        val previousDefectNumber: String? = null,
        @Transient
        var defect: Defect? = null,
        @Transient
        var condition: Condition? = null,
        @Transient
        var observationName: ObservationName? = null,
        @Transient
        var photos: List<Photo>? = null
) : MobileAppCreatedEntity(uuid, createdBy, updatedBy)
