package com.uav_recon.app.api.repositories

import com.uav_recon.app.api.entities.db.Observation
import org.springframework.data.repository.CrudRepository
import java.util.Optional

interface ObservationRepository : CrudRepository<Observation, String> {
    fun findAllByInspectionIdAndDeletedIsFalse(inspectionId: String): List<Observation>
    fun findByUuidAndInspectionIdAndDeletedIsFalse(id: String, inspectionId: String): Optional<Observation>
}
