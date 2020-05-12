package com.uav_recon.app.api.repositories

import com.uav_recon.app.api.entities.db.Project
import org.springframework.data.repository.CrudRepository

interface ProjectRepository : CrudRepository<Project, Long> {
    fun findAllByDeletedIsFalseAndCompanyId(companyId: Long) : List<Project>
}