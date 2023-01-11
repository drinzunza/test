package com.uav_recon.app.api.services

import com.fasterxml.jackson.databind.ObjectMapper
import com.uav_recon.app.api.controllers.handlers.AccessDeniedException
import com.uav_recon.app.api.entities.db.*
import com.uav_recon.app.api.entities.requests.bridge.CompanyDto
import com.uav_recon.app.api.repositories.CompanyRepository
import com.uav_recon.app.api.repositories.CompanyStructureTypeRepository
import com.uav_recon.app.api.repositories.EtagRepository
import com.uav_recon.app.api.repositories.StructureTypeRepository
import org.springframework.stereotype.Service
import java.util.*

@Service
class CompanyService(
    private val companyRepository: CompanyRepository,
    private val structureTypeRepository: StructureTypeRepository,
    private val etagRepository: EtagRepository,
    private val companyStructureTypeRepository: CompanyStructureTypeRepository,
    private val fileService: FileService
) {

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

        val types = structureTypeRepository.findAll().toList()
        val companyTypes = companyStructureTypeRepository.findAllByCompanyIdIn(companies.map { it.id })
        return companies.map { c -> c.toDto(types, companyTypes) }
    }

    fun getCompanyDto(user: User, companyId: Long): CompanyDto? {
        companyRepository.findFirstById(companyId)?.let {
            val types = structureTypeRepository.findAll().toList()
            val companyTypes = companyStructureTypeRepository.findAllByCompanyId(companyId)
            return it.toDto(types, companyTypes)
        }
        return null
    }

    fun getNotDeleted(user: User, companyId: Long): CompanyDto {
        companyRepository.findFirstByDeletedIsFalseAndId(companyId)?.let {
            val types = structureTypeRepository.findAll().toList()
            val companyTypes = companyStructureTypeRepository.findAllByCompanyId(companyId)

            if (it.id == user.companyId) {
                // Users can see own company
                return it.toDto(types, companyTypes)
            } else if (user.admin && user.companyId != null && user.companyId == it.creatorCompanyId) {
                // Admins can see owner companies
                return it.toDto(types, companyTypes)
            }
        }

        throw AccessDeniedException()
    }

    fun save(user: User, body: CompanyDto): CompanyDto {
        val types = structureTypeRepository.findAll().toList()
        val companyTypes = companyStructureTypeRepository.findAllByCompanyId(body.id)

        // Admin can edit own company
        if (user.admin && user.companyId == body.id) {
            companyRepository.findFirstById(body.id)?.let {
                it.name = body.name
                it.ratingInverse = body.ratingInverse

                it.logo = body.logo
                it.updatedBy = user.id
                createEtag(listOf(it.id.toString()))
                return companyRepository.save(it).toDto(types, companyTypes)
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
                creatorCompanyId = user.companyId,
                ratingInverse = body.ratingInverse
            )
            company.name = body.name
            company.logo = body.logo
            company.updatedBy = user.id
            company.type = CompanyType.OWNER
            company.ratingInverse = body.ratingInverse
            createEtag(listOf(company.id.toString()))
            return companyRepository.save(company).toDto(types, companyTypes)
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

    private fun createEtag(ids: List<String>) {
        val change = EtagChange()
        ids.forEach { change.companies.add(it) }
        etagRepository.save(
            Etag(
            id = 0,
            hash = UUID.randomUUID().toString(),
            change = ObjectMapper().writeValueAsString(change)
        )
        )
    }

    private fun Company.toDto(types: List<StructureType>, companyTypes: List<CompanyStructureType>) = CompanyDto(
        id = id,
        name = name,
        logo = logo?.let { fileService.generateSignedLink(it) },
        type = type,
        ratingInverse = ratingInverse,
        structureTypes = types.filter {
            companyTypes.filter { it.companyId == id }.map { it.structureTypeId }.contains(it.id)
        }.map { t -> t.toDto() }
    )
}
