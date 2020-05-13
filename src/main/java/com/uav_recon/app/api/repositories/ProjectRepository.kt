package com.uav_recon.app.api.repositories

import com.uav_recon.app.api.entities.db.Project
import org.springframework.data.repository.CrudRepository

interface ProjectRepository : CrudRepository<Project, Long> {
    fun findFirstById(id: Long) : Project?
    fun findFirstByDeletedIsFalseAndId(id: Long) : Project?
    fun findAllByDeletedIsFalseAndCompanyId(companyId: Long) : List<Project>
}