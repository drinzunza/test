package com.uav_recon.app.api.repositories

import com.uav_recon.app.api.entities.db.ObservationDefect
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.CrudRepository
import java.util.*

interface ObservationDefectRepository : CrudRepository<ObservationDefect, String> {
    fun findAllByObservationIdAndDeletedIsFalse(observationId: String): List<ObservationDefect>
    fun findByUuidAndDeletedIsFalse(observationId: String): Optional<ObservationDefect>
    fun findByUuidAndObservationIdAndDeletedIsFalse(uuid: String, observationId: String): Optional<ObservationDefect>
    fun countById(id: String): Long

    fun findFirstByIdStartsWithAndIdEndsWithOrderByIdDesc(prefix: String, suffix: String): ObservationDefect?
    fun findAllByIdStartsWithAndIdEndsWith(prefix: String, suffix: String): List<ObservationDefect>

    @Query(value = "SELECT id FROM ObservationDefect WHERE id = '?1'")
    fun getObservationDefectsDisplayId(id: String): List<ObservationDefect>
}
