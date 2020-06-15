package com.uav_recon.app.api.services

import com.uav_recon.app.api.entities.db.*

abstract class BaseService {

    fun Inspection.hasInspectionRole(user: User, roles: List<InspectionRole>, role: Role): Boolean {
        return roles.any { user.id == it.userId && uuid == it.inspectionId && (it.roles?.contains(role) ?: false) }
    }

    fun Inspection.hasProjectRole(user: User, roles: List<ProjectRole>, role: Role): Boolean {
        return roles.any { user.id == it.userId && projectId == it.projectId && (it.roles?.contains(role) ?: false) }
    }

    fun Project.hasAnyInspectionRole(user: User, inspections: List<Inspection>, roles: List<InspectionRole>): Boolean {
        val projectInspections = inspections.filter { id == it.projectId }
        return roles.any { role ->
            user.id == role.userId && projectInspections.any { it.uuid == role.inspectionId } && !role.roles.isNullOrEmpty()
        }
    }

    fun Project.hasAnyProjectRole(user: User, roles: List<ProjectRole>): Boolean {
        return roles.any { user.id == it.userId && id == it.projectId && !it.roles.isNullOrEmpty() }
    }
}