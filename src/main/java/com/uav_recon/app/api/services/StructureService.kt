package com.uav_recon.app.api.services

import com.fasterxml.jackson.databind.ObjectMapper
import com.uav_recon.app.api.controllers.dto.admin.AdminStructureInDTO
import com.uav_recon.app.api.controllers.dto.admin.AdminStructureOutDTO
import com.uav_recon.app.api.entities.db.*
import com.uav_recon.app.api.repositories.*
import org.springframework.stereotype.Service
import java.util.*
import javax.transaction.Transactional
import javax.validation.constraints.NotEmpty

@Service
class StructureService(
        private val structureRepository: StructureRepository,
        private val companyRepository: CompanyRepository,
        private val etagRepository: EtagRepository,
        private val structureComponentService: StructureComponentService,
        private val observationDefectRepository: ObservationDefectRepository,
        private val structureTypeRepository: StructureTypeRepository
) {

    fun regenerateObservationDefectIds(structureId: String, code: String) {
        val defects = observationDefectRepository.getByStructureId(structureId)
        defects.forEach {
            val oldStructureId = it.id.replace("-\\w-[\\d]{3}-[\\d]+-[\\d]{8}".toRegex(), "")
            val newId = it.id.replace(oldStructureId, code)
            it.id = newId
        }
        observationDefectRepository.saveAll(defects)
    }

    fun listStructures(actor: User, companyId: Long?): List<AdminStructureOutDTO> {
        val structureTypes = structureTypeRepository.findAll().toList()
        return if (companyId == null) {
            structureRepository.listByParentCompanyId(actor.companyId!!).map { s -> s.toOutDto(structureTypes) }
        } else {
            structureRepository.findAllByDeletedIsFalseAndCompanyId(companyId).map { s -> s.toOutDto(structureTypes) }
        }
    }

    @Throws(Error::class)
    fun get(structureId: String): AdminStructureOutDTO {
        structureRepository.findFirstById(structureId)?.let { return it.toOutDto(structureTypeRepository.findAll().toList()) }
        throw Error(404, "Structure with this id not found")
    }

    @Throws(Error::class)
    @Transactional
    fun create(dto: AdminStructureInDTO, actor: User): AdminStructureOutDTO {
        val structureTypes = structureTypeRepository.findAll().toList()
        val companies = companyRepository.findAll().toList()
        val structure = dto.toStructure(structureTypes, companies)
        if (structure.id.isBlank()) {
            structure.id = UUID.randomUUID().toString()
        }
        checkAllowForEditingStructure(structure, actor)
        if (structureRepository.existsById(structure.id))
            throw Error(400, "Structure with this id already exist")
        createEtag(listOf(structure.id))
        structureComponentService.refreshStructureComponents(actor.companyId!!, structure.id, structure.structureTypeId)
        structure.primaryOwner = structure.companyId?.let { companyRepository.findFirstById(it)?.name }
        return structureRepository.save(structure).toOutDto(structureTypes)
    }

    @Throws(Error::class)
    @Transactional
    fun update(id: String, dto: AdminStructureInDTO, actor: User): AdminStructureOutDTO {
        val structureTypes = structureTypeRepository.findAll().toList()
        val companies = companyRepository.findAll().toList()
        structureRepository.findFirstById(id)?.let {
            val structure = dto.toStructure(structureTypes, companies)
            it.id = dto.id
            it.code = dto.code
            it.name = dto.name
            it.structureTypeId = structure.structureTypeId
            it.companyId = structure.companyId
            it.caltransBridgeNo = dto.caltransBridgeNo
            it.postmile = dto.postmile
            it.beginStationing = dto.beginStationing
            it.endStationing = dto.endStationing

            checkAllowForEditingStructure(it, actor)
            createEtag(listOf(it.id))
            regenerateObservationDefectIds(id, it.code)
            structureComponentService.refreshStructureComponents(actor.companyId!!, it.id, it.structureTypeId)
            it.primaryOwner = it.companyId?.let { companyRepository.findFirstById(it)?.name }
            return structureRepository.save(it).toOutDto(structureTypes)
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

    private fun Structure.toOutDto(types: List<StructureType>) = AdminStructureOutDTO(
            id = id,
            code = code,
            name = name,
            type = types.find { it.id == structureTypeId }?.code,
            clientId = companyId,
            caltransBridgeNo = caltransBridgeNo,
            postmile = postmile,
            beginStationing = beginStationing,
            endStationing = endStationing
    )

    private fun AdminStructureInDTO.toStructure(types: List<StructureType>, companies: List<Company>) = Structure(
            id = id,
            code = code,
            name = name,
            structureTypeId = types.find { it.code == type }?.id,
            primaryOwner = companies.find { it.id == clientId }?.name,
            caltransBridgeNo = caltransBridgeNo,
            postmile = postmile,
            beginStationing = beginStationing,
            endStationing = endStationing,
            deleted = false,
            companyId = clientId
    )
}
