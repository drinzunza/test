package com.uav_recon.app.api.repositories

import com.uav_recon.app.api.entities.db.Structure
import org.springframework.data.repository.CrudRepository

interface StructureRepository : CrudRepository<Structure, String> {
    fun findAllByCompanyId(companyId: Long): List<Structure>
    fun findAllByIdIn(ids: List<String>): List<Structure>
    fun findAllByIdInAndTypeContains(ids: List<String>, buildType: String): List<Structure>
    fun findAllByTypeContains(buildType: String): List<Structure>
    fun findFirstById(structureId: String): Structure?
}