package com.uav_recon.app.api.entities.db

import java.io.Serializable
import javax.persistence.*

@Entity
@Table(name = "observation_defect")
class ObservationDefect : Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    var id: Int = 0
    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "defect_id", referencedColumnName = "id")
    var defect: Defect? = null
    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "condition_id", referencedColumnName = "id")
    var condition: Condition? = null
    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "observation_id", referencedColumnName = "id")
    var observation: Observation? = null
    @Column(name = "description")
    var description: String? = null
    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "material_id", referencedColumnName = "id")
    var material: Material? = null
    @Column(name = "critical_findings")
    var criticalFindings: String? = null
    @Column(name = "size")
    var size: String? = null
}