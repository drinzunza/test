package com.uav_recon.app.api.repositories

import com.uav_recon.app.api.entities.db.Structure
import com.uav_recon.app.api.entities.db.StructureComponentType
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Modifying
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.CrudRepository
import org.springframework.data.repository.query.Param
import javax.transaction.Transactional

interface StructureRepository : CrudRepository<Structure, String> {
    fun findAllByIdIn(ids: List<String>): List<Structure>
    fun findAllByCompanyId(companyId: Long): List<Structure>
    fun findAllByIdInAndType(ids: List<String>, buildType: StructureComponentType): List<Structure>
    fun findAllByType(buildType: StructureComponentType): List<Structure>
    fun findFirstById(structureId: String): Structure?

    @Query("""
        select s from Structure s 
            inner join Company c on s.companyId = c.id
            where c.creatorCompanyId = :companyId
    """ )
    fun listByParentCompanyId(@Param("companyId") companyId: Long): List<Structure>

    @Transactional
    @Modifying
    @Query("""
        delete from Structure  
            where id = :structureId
    """ )
    fun hardDeleteStructure(@Param("structureId") structureId: String)
}