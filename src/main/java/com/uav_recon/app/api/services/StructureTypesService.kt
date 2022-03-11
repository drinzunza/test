package com.uav_recon.app.api.services

import com.fasterxml.jackson.databind.ObjectMapper
import com.uav_recon.app.api.controllers.handlers.AccessDeniedException
import com.uav_recon.app.api.entities.db.*
import com.uav_recon.app.api.entities.requests.bridge.StructureTypeDto
import com.uav_recon.app.api.entities.requests.bridge.StructureTypeIdsDto
import com.uav_recon.app.api.repositories.CompanyStructureTypeRepository
import com.uav_recon.app.api.repositories.EtagRepository
import com.uav_recon.app.api.repositories.StructureTypeRepository
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional
import java.util.*

@Service
class StructureTypesService(
        private val structureTypeRepository: StructureTypeRepository,
        private val companyStructureTypeRepository: CompanyStructureTypeRepository,
        private val etagRepository: EtagRepository
) {
    fun getTypes(authenticatedUser: User): List<StructureTypeDto> {
        return structureTypeRepository.findAllByDeletedIsFalse().map { t -> t.toDto() }
    }

    fun getType(authenticatedUser: User, id: String): StructureTypeDto {
        return getDbType(authenticatedUser, id)?.toDto()
                ?: throw Error(171, "Not found type")
    }

    fun getDbType(authenticatedUser: User, id: String): StructureType? {
        return structureTypeRepository.findAll().firstOrNull { it.code == id }
    }

    @Transactional
    fun insert(authenticatedUser: User, body: StructureTypeDto): StructureTypeDto {
        if (!authenticatedUser.admin) throw AccessDeniedException()
        etagRepository.save(Etag(0, UUID.randomUUID().toString(), "{}"))
        return structureTypeRepository.save(body.toEntity(0)).toDto()
    }

    @Transactional
    fun update(authenticatedUser: User, body: StructureTypeDto): StructureTypeDto {
        if (!authenticatedUser.admin) throw AccessDeniedException()
        val type = structureTypeRepository.findByCodeAndDeletedIsFalse(body.id) ?: throw Error(171, "Not found type");
        createEtag(listOf(type.code))
        return structureTypeRepository.save(body.toEntity(type.id)).toDto()
    }

    fun delete(authenticatedUser: User, id: String) {
        if (!authenticatedUser.admin) throw AccessDeniedException()
        val type = getDbType(authenticatedUser, id) ?: throw Error(171, "Not found type")
        type.deleted = true
        structureTypeRepository.save(type)
    }

    fun getCompanyTypes(authenticatedUser: User, companyId: Long): List<StructureTypeDto> {
        val types = structureTypeRepository.findAll().toList()
        val companyTypes = companyStructureTypeRepository.findAllByCompanyId(companyId)

        return types.filter {
            companyTypes.filter { it.companyId == companyId }.map { it.structureTypeId }.contains(it.id)
        }.map { t -> t.toDto() }
    }

    @Transactional
    fun setCompanyTypes(authenticatedUser: User, companyId: Long, body: StructureTypeIdsDto): List<StructureTypeDto> {
        if (!authenticatedUser.admin) throw AccessDeniedException()

        val types = structureTypeRepository.findAll().toList()
        val companyTypes = companyStructureTypeRepository.findAllByCompanyId(companyId)
        companyStructureTypeRepository.deleteAll(companyTypes)

        val newCompanyTypes = mutableListOf<CompanyStructureType>()
        body.typeIds.forEach { id ->
            val typeId = types.find { it.code == id }?.id
            typeId?.let { newCompanyTypes.add(CompanyStructureType(0, companyId, it)) }
        }
        companyStructureTypeRepository.saveAll(newCompanyTypes.toList())

        return getCompanyTypes(authenticatedUser, companyId)
    }


    private fun createEtag(ids: List<String>) {
        val change = EtagChange()
        ids.forEach { change.structureTypes.add(it) }
        etagRepository.save(
            Etag(
                id = 0,
                hash = UUID.randomUUID().toString(),
                change = ObjectMapper().writeValueAsString(change)
            )
        )
    }
}
