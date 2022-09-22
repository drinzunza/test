package com.uav_recon.app.api.repositories

import com.uav_recon.app.api.entities.db.StructureSubdivision
import org.springframework.data.repository.CrudRepository

interface StructureSubdivisionRepository : CrudRepository<StructureSubdivision, String> {
    fun findFirstByUuid(uuid: String): StructureSubdivision?

    fun findAllByInspectionId(inspectionId: String): List<StructureSubdivision>
}