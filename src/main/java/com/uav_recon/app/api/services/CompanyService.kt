package com.uav_recon.app.api.services

import com.uav_recon.app.api.controllers.handlers.AccessDeniedException
import com.uav_recon.app.api.entities.db.Company
import com.uav_recon.app.api.entities.db.User
import com.uav_recon.app.api.entities.requests.bridge.CompanyDto
import com.uav_recon.app.api.repositories.CompanyRepository
import org.springframework.stereotype.Service

@Service
class CompanyService(private val companyRepository: CompanyRepository) {

    fun Company.toDto() = CompanyDto(
            id = id,
            name = name,
            logo = logo
    )

    fun save(user: User, companyId: Long?, body: CompanyDto): CompanyDto {
        if (user.admin && companyId == body.id) {
            companyRepository.findFirstById(companyId)?.let {
                it.name = body.name
                it.logo = body.logo
                it.updatedBy = user.id
                return companyRepository.save(it).toDto()
            }
        }
        throw AccessDeniedException()
    }
}