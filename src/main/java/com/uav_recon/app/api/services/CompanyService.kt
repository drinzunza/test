package com.uav_recon.app.api.services

import com.uav_recon.app.api.controllers.handlers.AccessDeniedException
import com.uav_recon.app.api.entities.db.Company
import com.uav_recon.app.api.entities.db.CompanyType
import com.uav_recon.app.api.entities.db.User
import com.uav_recon.app.api.entities.requests.bridge.CompanyDto
import com.uav_recon.app.api.repositories.CompanyRepository
import org.springframework.stereotype.Service

@Service
class CompanyService(private val companyRepository: CompanyRepository) {

    fun Company.toDto() = CompanyDto(
            id = id,
            name = name,
            logo = logo,
            type = type
    )

    fun listNotDeleted(user: User, type: CompanyType?): List<CompanyDto> {
        val companies = mutableListOf<Company>()
        // Users can see own company
        user.companyId?.let { companyRepository.findFirstByDeletedIsFalseAndId(it)?.let {
            if (type == null || type == CompanyType.INSPECTION) {
                companies.add(it)
            }
        }}

        // Admins can see owner companies
        if (user.admin && (type == null || type == CompanyType.OWNER) && user.companyId != null) {
            companies.addAll(
                    companyRepository.findAllByDeletedIsFalseAndTypeAndCreatorCompanyId(CompanyType.OWNER, user.companyId!!)
            )
        }

        return companies.map { c -> c.toDto() }
    }

    fun getNotDeleted(user: User, companyId: Long): CompanyDto {
        companyRepository.findFirstByDeletedIsFalseAndId(companyId)?.let {
            if (it.id == user.companyId) {
                // Users can see own company
                return it.toDto()
            } else if (user.admin && user.companyId != null && user.companyId == it.creatorCompanyId) {
                // Admins can see owner companies
                return it.toDto()
            }
        }

        throw AccessDeniedException()
    }

    fun save(user: User, body: CompanyDto): CompanyDto {
        // Admin can edit own company
        if (user.admin && user.companyId == body.id) {
            companyRepository.findFirstById(body.id)?.let {
                it.name = body.name
                it.logo = body.logo
                it.updatedBy = user.id
                return companyRepository.save(it).toDto()
            }
        }
        // Admin can edit owner companies
        if (user.admin && body.type == CompanyType.OWNER) {
            var company = companyRepository.findFirstById(body.id)
            if (company == null) company = Company(
                    name = body.name,
                    logo = body.logo,
                    createdBy = user.id,
                    updatedBy = user.id,
                    type = CompanyType.OWNER,
                    creatorCompanyId = user.companyId
            )
            company.name = body.name
            company.logo = body.logo
            company.updatedBy = user.id
            company.type = CompanyType.OWNER
            return companyRepository.save(company).toDto()
        }

        throw AccessDeniedException()
    }

    fun delete(user: User, companyId: Long) {
        companyRepository.findFirstById(companyId)?.let {
            // Admin can delete OWNER company
            if (user.admin && it.type == CompanyType.OWNER && it.creatorCompanyId == user.companyId) {
                it.deleted = true
                companyRepository.save(it)
                return
            }
        }
        throw AccessDeniedException()
    }
}