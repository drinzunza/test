package com.uav_recon.app.api.repositories

import com.uav_recon.app.api.entities.db.ObservationDefect
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.CrudRepository
import java.util.*

interface ObservationDefectRepository : CrudRepository<ObservationDefect, String> {
    fun findAllByDeletedIsFalseAndObservationIdIn(ids: List<String>): List<ObservationDefect>
    fun findAllByObservationIdAndDeletedIsFalse(observationId: String): List<ObservationDefect>
    fun findByUuidAndDeletedIsFalse(observationId: String): Optional<ObservationDefect>
    fun findByUuidAndObservationIdAndDeletedIsFalse(uuid: String, observationId: String): Optional<ObservationDefect>
    fun countById(id: String): Long
    fun findAllByIdLike(idRegexp: String): List<ObservationDefect>
    fun findFirstByUuidAndDeletedIsFalse(observationDefectId: String): ObservationDefect?
    fun findFirstByObservationIdAndIdAndDeletedIsFalse(observationId: String, displayId: String): ObservationDefect?
}
