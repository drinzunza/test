package com.uav_recon.app.api.services

import com.uav_recon.app.api.entities.db.StructureComponent
import com.uav_recon.app.api.entities.db.StructureComponentType
import com.uav_recon.app.api.repositories.CompanyRepository
import com.uav_recon.app.api.repositories.ComponentRepository
import com.uav_recon.app.api.repositories.StructureComponentRepository
import com.uav_recon.app.api.repositories.StructureRepository
import org.springframework.stereotype.Service
import javax.transaction.Transactional

@Service
class StructureComponentService(
        private val structureComponentRepository: StructureComponentRepository,
        private val componentRepository: ComponentRepository,
        private val structureRepository: StructureRepository
) {

    @Transactional
    fun refreshStructureComponents(companyId: Long, structureId: String, type: StructureComponentType) {
        structureComponentRepository.deleteByStructureId(structureId)
        val components = componentRepository.findAllByCompanyIdAndType(companyId, type)
        val structureComponents = components.map {
            StructureComponent(0, structureId, it.id)
        }
        structureComponentRepository.saveAll(structureComponents)
    }

    @Transactional
    fun refreshStructureComponents(companyId: Long) {
        val structures = structureRepository.listByParentCompanyId(companyId)
        val components = componentRepository.findAllByCompanyId(companyId)

        val structureComponents = mutableListOf<StructureComponent>()
        structures.forEach { structure ->
            components.filter { it.type == structure.type }.forEach { component ->
                structureComponents.add(StructureComponent(0, structure.id, component.id))
            }
        }

        structureComponentRepository.deleteByStructureIdIn(structures.map { it.id })
        structureComponentRepository.saveAll(structureComponents)
    }
}