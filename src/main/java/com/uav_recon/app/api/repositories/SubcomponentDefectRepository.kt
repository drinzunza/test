package com.uav_recon.app.api.repositories

import com.uav_recon.app.api.entities.db.SubcomponentDefect
import org.springframework.data.repository.CrudRepository

interface SubcomponentDefectRepository : CrudRepository<SubcomponentDefect, Int> {
    fun findAllBySubcomponentId(subcomponentId: String): List<SubcomponentDefect>
    fun findAllBySubcomponentIdIn(subcomponentId: List<String>): List<SubcomponentDefect>
}