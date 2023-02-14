package com.uav_recon.app.api.entities.db

import com.uav_recon.app.api.entities.requests.bridge.ObservationStructureSubdivisionDto
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.Id
import javax.persistence.Table

@Entity
@Table(name = "observation_structure_subdivision")
class ObservationStructureSubdivision(
    @Id
    val uuid: String,
    @Column(name = "structure_subdivision_id")
    var structureSubdivisionId: String,
    @Column(name = "observation_id")
    var observationId: String,
    @Column(name = "dimension_number")
    var dimensionNumber: Int = 0,
    @Transient
    var computedHealthIndex: Double? = null
)
