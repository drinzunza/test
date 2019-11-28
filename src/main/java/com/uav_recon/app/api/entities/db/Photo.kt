package com.uav_recon.app.api.entities.db

import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.Table

@Entity
@Table(name = "photos")
class Photo(
        uuid: String,
        createdBy: Int,
        updatedBy: Int,
        @Column(name = "observation_defect_id")
        val observationDefectId: String,
        val link: String,
        var name: String? = null,
        var latitude: Double? = null,
        var longitude: Double? = null,
        var altitude: Double? = null,
        var drawables: String? = null,
        @Column(name = "is_deleted")
        var deleted: Boolean? = false
) : MobileAppCreatedEntity(uuid, createdBy, updatedBy)
