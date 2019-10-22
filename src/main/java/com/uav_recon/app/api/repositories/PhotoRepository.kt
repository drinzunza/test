package com.uav_recon.app.api.repositories

import com.uav_recon.app.api.entities.db.ObservationDefect
import com.uav_recon.app.api.entities.db.Photo
import org.springframework.data.repository.CrudRepository

interface PhotoRepository : CrudRepository<Photo, Int> {
    fun findAllByObservationDefect(defect: ObservationDefect): List<Photo>
}