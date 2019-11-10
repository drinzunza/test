package com.uav_recon.app.api.repositories

import com.uav_recon.app.api.entities.db.Observation
import org.springframework.data.repository.CrudRepository

interface ObservationRepository : CrudRepository<Observation, String> {
    fun findAllByInspectionId(inspectionId: String): List<Observation>
}
