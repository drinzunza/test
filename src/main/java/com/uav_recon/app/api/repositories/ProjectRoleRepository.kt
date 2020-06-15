package com.uav_recon.app.api.repositories

import com.uav_recon.app.api.entities.db.ProjectRole
import org.springframework.data.repository.CrudRepository

interface ProjectRoleRepository : CrudRepository<ProjectRole, Long> {
    fun findAllByProjectIdAndUserId(projectId: Long, userId: Long) : List<ProjectRole>
    fun findAllByProjectId(projectId: Long) : List<ProjectRole>
    fun findAllByProjectIdIn(projectIds: List<Long>) : List<ProjectRole>
}