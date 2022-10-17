package com.uav_recon.app.api.entities.db

import com.uav_recon.app.api.entities.requests.bridge.StructureSubdivisionDto
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.Id
import javax.persistence.Table

@Entity
@Table(name = "structure_subdivision")
class StructureSubdivision(
    @Id
    val uuid: String,
    @Column(name = "inspection_id")
    var inspectionId: String,
    @Column(name = "name")
    var name: String? = null,
    @Column(name = "number")
    var number: String? = null,
    @Column(name = "sgr_rating")
    var sgrRating: String? = null,
    @Transient
    var observationStructureSubdivisions: List<ObservationStructureSubdivision>? = null
)
