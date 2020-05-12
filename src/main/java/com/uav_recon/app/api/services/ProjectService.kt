package com.uav_recon.app.api.services

import com.uav_recon.app.api.entities.db.*
import com.uav_recon.app.api.entities.requests.bridge.CompanyDto
import com.uav_recon.app.api.entities.requests.bridge.ProjectDto
import com.uav_recon.app.api.entities.requests.bridge.SimpleStructureDto
import com.uav_recon.app.api.entities.requests.bridge.SimpleUserDto
import com.uav_recon.app.api.repositories.*
import org.springframework.stereotype.Service

@Service
class ProjectService(
        private val projectRepository: ProjectRepository,
        private val companyRepository: CompanyRepository,
        private val structureRepository: StructureRepository,
        private val projectRoleRepository: ProjectRoleRepository,
        private val userRepository: UserRepository,
        private val projectStructureRepository: ProjectStructureRepository
) {

    fun Project.toDto() = ProjectDto(
            id = id,
            name = name,
            company = companyRepository.findFirstById(companyId)?.toDto(),
            structures = getStructures(),
            projectManagers = getUsers(Role.PM),
            createdAt = createdAt,
            updatedAt = updatedAt
    )

    fun Structure.toDto() = SimpleStructureDto(
            id = id,
            name = name
    )

    fun Company.toDto() = CompanyDto(
            id = id,
            name = name
    )

    fun User.toDto() = SimpleUserDto(
            id = id,
            firstName = firstName,
            lastName = lastName,
            email = email
    )

    fun listNotDeleted(user: User, companyId: Long?): List<ProjectDto> {
        // Admin can see all projects own company
        if (user.admin && user.companyId == companyId && companyId != null) {
            return projectRepository.findAllByDeletedIsFalseAndCompanyId(companyId).map { i -> i.toDto() }
        }
        // Others can see only assigned projects
        if (!user.admin && user.companyId == companyId && companyId != null) {
            return projectRepository.findAllByDeletedIsFalseAndCompanyId(companyId)
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

        throw Error(172, "Access denied to project")
    }

    fun save(user: User, body: ProjectDto): ProjectDto {
        return body
    }

    fun delete(user: User, projectId: Long) {
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
}