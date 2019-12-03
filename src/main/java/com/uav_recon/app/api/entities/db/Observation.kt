package com.uav_recon.app.api.entities.db

import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.Table
import javax.persistence.Transient

@Entity
@Table(name = "observations")
class Observation(
        uuid: String,
        val id: String,
        createdBy: Int,
        updatedBy: Int,
        @Column(name = "inspection_id")
        val inspectionId: String,
        @Column(name = "structural_component_id")
        var structuralComponentId: String? = null,
        @Column(name = "sub_component_id")
        var subComponentId: String? = null,
        @Column(name = "drawing_number")
        var drawingNumber: String? = null,
        @Column(name = "room_number")
        var roomNumber: String? = null,
        @Column(name = "location_description")
        var locationDescription: String? = null,
        @Column(name = "dimension_number")
        var dimensionNumber: Int? = 0,
        @Column(name = "is_deleted")
        var deleted: Boolean? = false,
        @Transient
        var structuralComponent: Component? = null,
        @Transient
        var code: String? = null,
        @Transient
        var subcomponent: Subcomponent? = null
) : MobileAppCreatedEntity(uuid, createdBy, updatedBy)
