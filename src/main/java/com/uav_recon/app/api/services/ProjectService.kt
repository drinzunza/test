package com.uav_recon.app.api.services

import com.uav_recon.app.api.controllers.handlers.AccessDeniedException
import com.uav_recon.app.api.entities.db.*
import com.uav_recon.app.api.entities.requests.bridge.*
import com.uav_recon.app.api.repositories.*
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional

@Service
class ProjectService(
        private val projectRepository: ProjectRepository,
        private val structureRepository: StructureRepository,
        private val projectRoleRepository: ProjectRoleRepository,
        private val userRepository: UserRepository,
        private val projectStructureRepository: ProjectStructureRepository
) {

    fun Project.toDto() = ProjectDto(
            id = id,
            name = name,
            structures = getStructures(),
            projectManagers = getUsers(Role.PM),
            createdAt = createdAt,
            updatedAt = updatedAt
    )

    fun Project.toIdsDto() = ProjectIdsDto(
            id = id,
            name = name,
            structures = getStructureIds(),
            projectManagers = getUserIds(Role.PM),
            createdAt = createdAt,
            updatedAt = updatedAt
    )

    fun Structure.toDto() = SimpleStructureDto(
            id = id,
            name = name
    )

    fun User.toDto() = SimpleUserDto(
            id = id,
            firstName = firstName,
            lastName = lastName,
            email = email
    )

    fun listNotDeleted(user: User): List<ProjectDto> {
        // Admin can see all projects own company
        if (user.admin && user.companyId != null) {
            return projectRepository.findAllByDeletedIsFalseAndCompanyId(user.companyId!!).map { i -> i.toDto() }
        }
        // Others can see only assigned projects
        if (!user.admin && user.companyId != null) {
            return projectRepository.findAllByDeletedIsFalseAndCompanyId(user.companyId!!)
                    .map { i -> i.toDto() }
                    .filter { it.hasAnyRole(user) }
        }
        return listOf()
    }

    fun getNotDeleted(user: User, projectId: Long): ProjectDto {
        val project = projectRepository.findFirstByDeletedIsFalseAndId(projectId)
        val companyId = project?.companyId

        if (project == null) throw Error(171, "Not found project")

        // Admin can see all projects own company
        if (user.admin && user.companyId == companyId && companyId != null) {
            return project.toDto()
        }
        // Others can see only assigned projects
        if (!user.admin && user.companyId == companyId && companyId != null && project.toDto().hasAnyRole(user)) {
            return project.toDto()
        }

        throw AccessDeniedException()
    }

    fun save(user: User, body: ProjectIdsDto): ProjectDto {
        val project = if (body.id != 0L) projectRepository.findFirstById(body.id) else null

        if (user.admin && project != null && project.companyId == user.companyId) {
            // Admin can edit projects own company
            project.name = body.name
            project.updatedBy = user.id
            return updateProject(user, project, body)
        } else if (user.admin && project == null) {
            // Admin can add projects own company
            return addProject(user, body)
        } else {
            throw AccessDeniedException()
        }
    }

    @Transactional
    fun updateProject(user: User, project: Project, body: ProjectIdsDto): ProjectDto {
        projectRepository.save(project)

        val existStructures = projectStructureRepository.findAllByProjectId(project.id)
        val projectStructures = body.structures.map {
            ProjectStructure(
                    projectId = project.id,
                    structureId = it
            )
        }
        projectStructureRepository.deleteAll(existStructures)
        projectStructureRepository.saveAll(projectStructures)

        val existRoles = projectRoleRepository.findAllByProjectId(project.id)
        val projectRoles = body.projectManagers.map {
            ProjectRole(
                    projectId = project.id,
                    userId = user.id,
                    roles = arrayOf(Role.PM)
            )
        }
        projectRoleRepository.deleteAll(existRoles)
        projectRoleRepository.saveAll(projectRoles)

        return project.toDto()
    }

    @Transactional
    fun addProject(user: User, body: ProjectIdsDto): ProjectDto {
        var newProject = Project(
                name = body.name,
                companyId = user.companyId ?: 0,
                createdBy = user.id,
                updatedBy = user.id
        )
        newProject = projectRepository.save(newProject)

        val projectStructures = body.structures.map {
            ProjectStructure(
                    projectId = newProject.id,
                    structureId = it
            )
        }
        val projectRoles = body.projectManagers.map {
            ProjectRole(
                    projectId = newProject.id,
                    userId = user.id,
                    roles = arrayOf(Role.PM)
            )
        }
        projectRoleRepository.saveAll(projectRoles)
        projectStructureRepository.saveAll(projectStructures)
        return newProject.toDto()
    }

    fun delete(user: User, projectId: Long) {
        val project = projectRepository.findFirstById(projectId)

        // Admin can delete projects own company
        if (user.admin && project != null && project.companyId == user.companyId) {
            project.deleted = true
            projectRepository.save(project)
        } else {
            throw AccessDeniedException()
        }
    }

    fun ProjectDto.hasRole(user: User, role: Role): Boolean {
        return projectRoleRepository.findAllByProjectIdAndUserId(id, user.id).any {
            it.roles?.contains(role) ?: false
        }
    }

    fun ProjectDto.hasAnyRole(user: User): Boolean {
        return projectRoleRepository.findAllByProjectIdAndUserId(id, user.id).any {
            it.roles != null
        }
    }

    fun Project.getUsers(role: Role): List<SimpleUserDto> {
        val results = mutableListOf<SimpleUserDto>()
        val projectRoles = projectRoleRepository.findAllByProjectId(id)
                .filter { it.roles?.contains(role) ?: false }
        projectRoles.forEach {
            userRepository.findFirstById(it.userId)?.toDto()?.let {
                results.add(it)
            }
        }
        return results
    }

    fun Project.getStructures(): List<SimpleStructureDto> {
        val results = mutableListOf<SimpleStructureDto>()
        val projectStructures = projectStructureRepository.findAllByProjectId(id)
        projectStructures.forEach {
            structureRepository.findFirstById(it.structureId)?.toDto()?.let {
                results.add(it)
            }
        }
        return results
    }

    fun Project.getUserIds(role: Role): List<Long> {
        val results = mutableListOf<Long>()
        val projectRoles = projectRoleRepository.findAllByProjectId(id)
                .filter { it.roles?.contains(role) ?: false }
        projectRoles.forEach {
            userRepository.findFirstById(it.userId)?.toDto()?.let {
                results.add(it.id)
            }
        }
        return results
    }

    fun Project.getStructureIds(): List<String> {
        val results = mutableListOf<String>()
        val projectStructures = projectStructureRepository.findAllByProjectId(id)
        projectStructures.forEach {
            structureRepository.findFirstById(it.structureId)?.toDto()?.let {
                results.add(it.id)
            }
        }
        return results
    }
}