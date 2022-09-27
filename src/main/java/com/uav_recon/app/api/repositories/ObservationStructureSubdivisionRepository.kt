package com.uav_recon.app.api.repositories

import com.uav_recon.app.api.entities.db.ObservationStructureSubdivision
import org.springframework.data.repository.CrudRepository

interface ObservationStructureSubdivisionRepository : CrudRepository<ObservationStructureSubdivision, String> {
    fun findAllByObservationId(observationId: String): List<ObservationStructureSubdivision>

    fun findFirstByUuid(uuid: String): ObservationStructureSubdivision?

    fun findAllByStructureSubdivisionId(structureSubdivisionId: String): List<ObservationStructureSubdivision>
}