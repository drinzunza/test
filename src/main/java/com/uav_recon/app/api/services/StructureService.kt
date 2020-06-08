package com.uav_recon.app.api.services

import com.fasterxml.jackson.databind.ObjectMapper
import com.uav_recon.app.api.entities.db.*
import com.uav_recon.app.api.repositories.CompanyRepository
import com.uav_recon.app.api.repositories.EtagRepository
import com.uav_recon.app.api.repositories.StructureRepository
import com.uav_recon.app.api.services.mapper.AdminStructureServiceMapper
import org.mapstruct.factory.Mappers
import org.springframework.stereotype.Service
import java.util.*
import javax.transaction.Transactional

@Service
class StructureService(
        private val structureRepository: StructureRepository,
        private val companyRepository: CompanyRepository,
        private val etagRepository: EtagRepository,
        private val structureComponentService: StructureComponentService
) {

    private val structureMapper = Mappers.getMapper(AdminStructureServiceMapper::class.java)

    fun listStructures(actor: User, companyId: Long?): List<Structure> {
        return if (companyId == null) {
            structureRepository.listByParentCompanyId(actor.companyId!!)
        } else {
            structureRepository.findAllByDeletedIsFalseAndCompanyId(companyId)
        }
    }

    @Throws(Error::class)
    fun get(structureId: String): Structure {
        structureRepository.findFirstById(structureId)?.let { return it }
        throw Error(404, "Structure with this id not found")
    }

    @Throws(Error::class)
    @Transactional
    fun create(structure: Structure, actor: User): Structure {
        checkAllowForEditingStructure(structure, actor)
        if (structureRepository.existsById(structure.id))
            throw Error(400, "Structure with this id already exist")
        createEtag(listOf(structure.id))
        structureComponentService.refreshStructureComponents(structure.id, structure.type)
        return structureRepository.save(structure)
    }

    @Throws(Error::class)
    @Transactional
    fun update(id: String, data: Structure, actor: User): Structure {
        structureRepository.findFirstById(id)?.let {
            structureMapper.update(data, it)
            checkAllowForEditingStructure(it, actor)
            createEtag(listOf(it.id))
            structureComponentService.refreshStructureComponents(it.id, it.type)
            return structureRepository.save(it)
        }
        throw Error(404, "Structure with this id not found")
    }

    @Throws(Error::class)
    fun delete(structureId: String, actor: User): String {
        structureRepository.findFirstById(structureId)?.let {
            checkAllowForEditingStructure(it, actor)
            createEtag(listOf(it.id))
            structureRepository.safeDelete(it.id)
            return it.id
        }
        throw Error(404, "Structure with this id not found")
    }

    private fun checkAllowForEditingStructure(structure: Structure, actor: User) {
        if (structure.companyId != null) {
            val company = companyRepository.findFirstById(structure.companyId!!)
                    ?: throw  Error(19, "Company not found")
            if (structure.companyId != actor.companyId && actor.companyId != company.creatorCompanyId) {
                throw  Error(21, "action not allowed")
            }
        } else {
            throw  Error(22, "Company must have company owner")
        }
    }

    private fun createEtag(ids: List<String>) {
        val change = EtagChange()
        ids.forEach { change.structures.add(it) }
        etagRepository.save(Etag(
                id = 0,
                hash = UUID.randomUUID().toString(),
                change = ObjectMapper().writeValueAsString(change)
        ))
    }
}
