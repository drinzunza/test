package com.uav_recon.app.api.entities.db

import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.Table

@Entity
@Table(name = "reports")
class Report(
        uuid: String,
        createdBy: Int,
        updatedBy: Int,
        val link: String,
        @Column(name = "inspection_id")
        val inspectionId: String
) : MobileAppCreatedEntity(uuid, createdBy, updatedBy)

