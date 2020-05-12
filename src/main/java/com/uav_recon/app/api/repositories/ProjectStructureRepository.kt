package com.uav_recon.app.api.repositories

import com.uav_recon.app.api.entities.db.ProjectStructure
import org.springframework.data.repository.CrudRepository

interface ProjectStructureRepository : CrudRepository<ProjectStructure, Long> {
    fun findAllByProjectId(projectId: Long) : List<ProjectStructure>
}