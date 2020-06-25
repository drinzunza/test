package com.uav_recon.app.api.repositories

import com.uav_recon.app.api.entities.db.Structure
import com.uav_recon.app.api.entities.db.StructureComponentType
import org.springframework.data.jpa.repository.Modifying
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.CrudRepository
import org.springframework.data.repository.query.Param
import javax.transaction.Transactional

interface StructureRepository : CrudRepository<Structure, String> {
    fun findAllByIdIn(ids: List<String>): List<Structure>
    fun findAllByDeletedIsFalseAndIdIn(ids: List<String>): List<Structure>
    fun findAllByDeletedIsFalseAndCompanyId(companyId: Long): List<Structure>
    fun findAllByIdInAndType(ids: List<String>, buildType: StructureComponentType): List<Structure>
    fun findAllByType(buildType: StructureComponentType): List<Structure>
    fun findFirstById(structureId: String): Structure?

    @Query("select s from Structure s " +
            "inner join Company c on s.companyId = c.id " +
            "where c.creatorCompanyId = ?1 and s.deleted = false and c.deleted = false")
    fun listByParentCompanyId(companyId: Long): List<Structure>

    @Query("UPDATE Structure s SET s.deleted = true WHERE s.id = ?1")
    @Modifying
    @Transactional
    fun safeDelete(structureId: String)
}