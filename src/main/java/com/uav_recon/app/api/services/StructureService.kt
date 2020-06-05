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
class StructureService(private val structureRepository: StructureRepository,
                       private val companyRepository: CompanyRepository,
                       private val etagRepository: EtagRepository,
                       private val structureComponentService: StructureComponentService
) {

    private val structureMapper = Mappers.getMapper(AdminStructureServiceMapper::class.java)

    fun listStructures(actor: User, companyId: Long?): List<Structure> {
        return if (companyId === null) {
            structureRepository.listByParentCompanyId(actor.companyId!!)
        } else {
            structureRepository.findAllByCompanyId(companyId)
        }
    }

    @Throws(Error::class)
    fun get(structureId: String): Structure {
        val optional = structureRepository.findById(structureId)
        if (!optional.isPresent) throw Error(404, "Structure with this id not found")
        return optional.get()
    }

    @Throws(Error::class)
    @Transactional
    fun create(structure: Structure, actor: User): Structure {
        checkAllowForEditingStructure(structure, actor)
        structureRepository.hardDeleteStructure(structure.id)
        if (structureRepository.existsById(structure.id)) throw Error(400, "Structure with this id already exist")
        createEtag(listOf(structure.id))
        structureComponentService.refreshStructureComponents(structure.id, structure.type)
        return structureRepository.save(structure)
    }

    @Throws(Error::class)
    @Transactional
    fun update(id: String, data: Structure, actor: User): Structure {

        val optional = structureRepository.findById(id)
        if (!optional.isPresent) throw Error(404, "Structure with this id not found")
        var structure = optional.get()

        structureMapper.update(data, structure)

        checkAllowForEditingStructure(structure, actor)
        createEtag(listOf(structure.id))
        structureComponentService.refreshStructureComponents(structure.id, structure.type)
        return structureRepository.save(structure)
    }

    @Throws(Error::class)
    fun delete(structureId: String, actor: User): String {
        val optional = structureRepository.findById(structureId)
        if (!optional.isPresent) throw Error(404, "Structure with this id not found")
        val structure = optional.get()

        checkAllowForEditingStructure(structure, actor)
        createEtag(listOf(structure.id))
        structureComponentService.deleteAllByStructure(structure.id)
        structureRepository.delete(structure)
        return structure.id
    }

    private fun checkAllowForEditingStructure(structure: Structure, actor: User) {
        val companyId: Long? = structure.companyId;

        if (companyId != null) {
            val company: Company = companyRepository.findFirstById(companyId) ?: throw  Error(19, "company not found")
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
