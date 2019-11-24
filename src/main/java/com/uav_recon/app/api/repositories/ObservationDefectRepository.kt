package com.uav_recon.app.api.repositories

import com.uav_recon.app.api.entities.db.ObservationDefect
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.CrudRepository
import java.util.*

interface ObservationDefectRepository : CrudRepository<ObservationDefect, String> {
    fun findAllByObservationIdAndDeletedIsFalse(observationId: String): List<ObservationDefect>
    fun findByUuidAndObservationIdAndDeletedIsFalse(uuid: String, observationId: String): Optional<ObservationDefect>
    fun countById(id: String): Long

    @Query("SELECT MAX(id) FROM ObservationDefect WHERE id LIKE '%?2' AND id LIKE '?1%'")
    fun getMaxDefectDisplayId(prefix: String, suffix: String): ObservationDefect?

    @Query(value = "SELECT id FROM ObservationDefect WHERE id = '?1'")
    fun getObservationDefectsDisplayId(id: String): List<ObservationDefect>
}
