package com.uav_recon.app.api.repositories

import com.uav_recon.app.api.entities.db.Defect
import org.springframework.data.repository.CrudRepository

interface DefectRepository : CrudRepository<Defect, String> {
    fun findAllByIdIn(ids: List<String>): List<Defect>
    fun findAllByIdInAndIdContains(ids: List<String>, buildType: String): List<Defect>
    fun findAllByIdContains(buildType: String): List<Defect>
    fun findFirstById(id: String): Defect?
}