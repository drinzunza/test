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
    fun findFirstByUuid(uuid: String): ObservationDefect?
    fun findFirstByUuidAndDeletedIsFalse(observationDefectId: String): ObservationDefect?
    fun findFirstByObservationIdAndIdAndDeletedIsFalse(observationId: String, displayId: String): ObservationDefect?
    fun findAllByObservationIdAndStructureSubdivisionIdAndDeletedIsFalse(
        observationId: String,
        structureSubdivisionId: String
    ): List<ObservationDefect>
    fun findAllByDeletedIsFalseAndObservationIdInAndStructureSubdivisionId(
        ids: List<String>,
        structureSubdivisionId: String
    ): List<ObservationDefect>


    @Query("select od " +
            "from Inspection i, Observation o, ObservationDefect od " +
            "where " +
            "      i.structureId = ?1 and " +
            "      o.inspectionId = i.uuid and " +
            "      od.observationId = o.uuid")
    fun getByStructureId(structureId: String): List<ObservationDefect>
}
