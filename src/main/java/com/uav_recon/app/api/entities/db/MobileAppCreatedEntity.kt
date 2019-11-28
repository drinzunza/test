package com.uav_recon.app.api.entities.db

import javax.persistence.Id
import javax.persistence.MappedSuperclass

@MappedSuperclass
abstract class MobileAppCreatedEntity(
        @Id
        val uuid: String,
        createdBy: Int,
        updatedBy: Int
) : MonitoredEntity(createdBy, updatedBy)
