package com.uav_recon.app.api.entities.db

import javax.persistence.Column
import javax.persistence.MappedSuperclass

@MappedSuperclass
abstract class MonitoredEntity(
        @Column(name = "created_by")
        val createdBy: Int,
        @Column(name = "updated_by")
        val updatedBy: Int
) : BaseEntity()
