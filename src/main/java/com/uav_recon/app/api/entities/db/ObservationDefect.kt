package com.uav_recon.app.api.entities.db

import com.vladmihalcea.hibernate.type.array.EnumArrayType
import org.hibernate.annotations.Parameter
import org.hibernate.annotations.TypeDef
import javax.persistence.Column
import javax.persistence.Entity
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
        id: String,
        createdBy: Int,
        updatedBy: Int,
        @Column(name = "observation_id")
        val observationId: String,
        @Column(name = "defect_id")
        var defectId: String? = null,
        @Column(name = "condition_id")
        var conditionId: String? = null,
        var description: String? = null,
        @Column(name = "material_id")
        var materialId: String? = null,
        @Column(name = "critical_findings", columnDefinition = "critical_finding[]")
        var criticalFindings: Array<CriticalFinding>?,
        @Column(name = "span_number")
        var spanNumber: Int? = 0,
        @Transient
        var material: Material? = null,
        @Transient
        var defect: Defect? = null,
        @Transient
        var condition: Condition? = null,
        @Transient
        var size: String? = null
) : MobileAppCreatedEntity(uuid, id, createdBy, updatedBy)
