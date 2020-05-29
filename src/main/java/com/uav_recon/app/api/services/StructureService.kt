package com.uav_recon.app.api.services

import com.uav_recon.app.api.entities.db.Company
import com.uav_recon.app.api.entities.db.Structure
import com.uav_recon.app.api.entities.db.User
import com.uav_recon.app.api.repositories.CompanyRepository
import com.uav_recon.app.api.repositories.StructureRepository
import org.springframework.data.crossstore.ChangeSetPersister
import org.springframework.security.core.userdetails.UserDetailsService
import org.springframework.stereotype.Service

@Service
class StructureService(private val structureRepository: StructureRepository,
                       private val companyRepository: CompanyRepository) {

    fun listStructures(actor: User, companyId: Long?): List<Structure> {
        return if (companyId === null)  {
            structureRepository.listByParentCompanyId(actor.companyId!!)
        } else {
            structureRepository.findAllByCompanyId(companyId)
        }
    }

    @Throws(Error::class)
    fun get(structureId: String): Structure {
        val optional = structureRepository.findById(structureId)
        if (!optional.isPresent) throw ChangeSetPersister.NotFoundException()
        return optional.get()
    }

    @Throws(Error::class)
    fun create(structure: Structure, actor: User): Structure {
        checkAllowForEditingStructure(structure, actor)
        return structureRepository.save(structure)
    }

    @Throws(Error::class)
    fun delete(structureId: String, actor: User): String {
        val optional = structureRepository.findById(structureId)
        if (!optional.isPresent) throw ChangeSetPersister.NotFoundException()
        val structure = optional.get()

        checkAllowForEditingStructure(structure, actor)
        structureRepository.delete(structure)
        return structure.id
    }

    private fun checkAllowForEditingStructure(structure: Structure, actor: User) {
        val companyId: Long? = structure.companyId;

        if (companyId != null) {
            val company: Company = companyRepository.findFirstById(companyId)?: throw  Error(19, "company not found")
            if (structure.companyId != actor.companyId && actor.companyId != company.creatorCompanyId) {
                throw  Error(21, "action not allowed")
            }
        } else {
            throw  Error(22, "Company must have company owner")
        }
    }
}
