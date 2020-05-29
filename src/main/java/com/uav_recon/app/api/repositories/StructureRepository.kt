package com.uav_recon.app.api.repositories

import com.uav_recon.app.api.entities.db.Structure
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.CrudRepository

interface StructureRepository : CrudRepository<Structure, String> {
    fun findAllByIdIn(ids: List<String>): List<Structure>
    fun findAllByCompanyId(companyId: Long): List<Structure>
    fun findAllByIdInAndTypeContains(ids: List<String>, buildType: String): List<Structure>
    fun findAllByTypeContains(buildType: String): List<Structure>
    fun findFirstById(structureId: String): Structure?

    @Query("""
        select s from Structure s 
            inner join Company c on s.companyId = c.id
            where c.creatorCompanyId = :companyId
    """ )
    fun listByParentCompanyId(companyId: Long): List<Structure>
}