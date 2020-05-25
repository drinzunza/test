package com.uav_recon.app.api.repositories

import com.uav_recon.app.api.entities.db.Observation
import org.springframework.data.repository.CrudRepository
import java.util.*

interface ObservationRepository : CrudRepository<Observation, String> {
    fun findAllByDeletedIsFalseAndInspectionIdIn(ids: List<String>): List<Observation>
    fun findAllByInspectionIdAndDeletedIsFalse(inspectionId: String): List<Observation>
    fun findByUuidAndDeletedIsFalse(id: String): Optional<Observation>
    fun findByUuidAndInspectionIdAndDeletedIsFalse(id: String, inspectionId: String): Optional<Observation>
    fun findFirstByUuidAndDeletedIsFalse(id: String): Observation?
}
