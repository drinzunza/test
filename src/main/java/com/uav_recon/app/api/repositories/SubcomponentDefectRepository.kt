package com.uav_recon.app.api.repositories

import com.uav_recon.app.api.entities.db.SubcomponentDefect
import org.springframework.data.jpa.repository.Modifying
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.CrudRepository
import org.springframework.transaction.annotation.Transactional

interface SubcomponentDefectRepository : CrudRepository<SubcomponentDefect, Int> {
    fun findAllBySubcomponentId(subcomponentId: String): List<SubcomponentDefect>
    fun findAllBySubcomponentIdIn(subcomponentId: List<String>): List<SubcomponentDefect>

    @Transactional
    @Modifying
    @Query("DELETE FROM SubcomponentDefect sd WHERE id NOT IN " +
            "(SELECT MIN(id) FROM SubcomponentDefect s GROUP BY s.subcomponentId, s.defectId)")
    fun deleteNotUnique()
}