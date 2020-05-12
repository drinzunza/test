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
        private val userRepository: UserRepository
) {

    fun Project.toDto() = ProjectDto(
            id = id,
            name = name,
            company = companyRepository.findFirstById(companyId)?.toDto(),
            structures = structureRepository.findAllByCompanyId(companyId).map { i -> i.toDto() },
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
        // SuperAdmin can see all projects
        if (user.admin && companyId != null) {
            return projectRepository.findAllByDeletedIsFalseAndCompanyId(companyId).map { i -> i.toDto() }
        }
        // Company admins can see projects own company
        if (!user.admin && user.companyId == companyId && companyId != null) {
            return projectRepository.findAllByDeletedIsFalseAndCompanyId(companyId).map { i -> i.toDto() }
                    .filter { it.hasRole(user, Role.ADMIN) }
        }
        // Other users see empty list
        return listOf()
    }

    fun ProjectDto.hasRole(user: User, role: Role): Boolean {
        return projectRoleRepository.findAllByProjectIdAndUserId(id, user.id).any {
            it.roles?.contains(role) ?: false
        }
    }

    fun Project.getUsers(role: Role): List<SimpleUserDto> {
        val results = mutableListOf<SimpleUserDto>()
        val users = projectRoleRepository.findAllByProjectId(id)
                .filter { it.roles?.contains(role) ?: false }
        users.forEach {
            userRepository.findFirstById(it.userId)?.toDto()?.let {
                results.add(it)
            }
        }
        return results
    }
}