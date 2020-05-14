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
            companies.add(it)
        }}

        // Admins can see owner companies
        // TODO add

        return companies.map { c -> c.toDto() }
    }

    fun getNotDeleted(user: User, companyId: Long): CompanyDto {
        val company = companyRepository.findFirstByDeletedIsFalseAndId(companyId)
        // Users can see own company
        if (company != null && company.id == user.companyId) {
            return company.toDto()
        }// else if () {
            // Admins can see owner companies
            // TODO add
        //}
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
        // TODO add

        throw AccessDeniedException()
    }

    fun delete(user: User, companyId: Long) {
        val company = companyRepository.findFirstById(companyId)

        // Admin can delete OWNER company
        if (user.admin && company != null && company.type == CompanyType.OWNER && company.id != user.companyId) {
            company.deleted = true
            companyRepository.save(company)
        } else {
            throw AccessDeniedException()
        }
    }
}