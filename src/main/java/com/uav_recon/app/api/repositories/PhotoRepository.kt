package com.uav_recon.app.api.repositories

import com.uav_recon.app.api.entities.db.Photo
import org.springframework.data.repository.CrudRepository

interface PhotoRepository : CrudRepository<Photo, String> {
    fun findAllByObservationDefectIdAndDeletedIsFalse(observationDefectId: String): List<Photo>
}
