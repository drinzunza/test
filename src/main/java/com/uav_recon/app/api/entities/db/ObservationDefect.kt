package com.uav_recon.app.api.entities.db

import java.io.Serializable
import javax.persistence.*

@Entity
@Table(name = "observation_defects")
class ObservationDefects : Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    var id: Int = 0
    @Column(name = "defect_id")
    var defectId: Int? = null
    @Column(name = "condition_id")
    var conditionId: Int? = null
    @Column(name = "observation_id")
    var observationId: Int? = null
    @Column(name = "description")
    var description: String? = null
    @Column(name = "material_id")
    var materialId: Int? = null
    @Column(name = "critical_findings")
    var criticalFindings: String? = null
    @Column(name = "size")
    var size: String? = null
}