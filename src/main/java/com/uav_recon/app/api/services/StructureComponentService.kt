package com.uav_recon.app.api.services

import com.uav_recon.app.api.entities.db.StructureComponent
import com.uav_recon.app.api.entities.db.StructureComponentType
import com.uav_recon.app.api.repositories.ComponentRepository
import com.uav_recon.app.api.repositories.StructureComponentRepository
import org.springframework.stereotype.Service
import javax.transaction.Transactional

@Service
class StructureComponentService(
        private val structureComponentRepository: StructureComponentRepository,
        private val componentRepository: ComponentRepository
) {

    @Transactional
    fun deleteAllByStructure(structureId: String) {
        structureComponentRepository.deleteByStructureId(structureId)
    }

    fun createForComponentType(structureId: String, type: StructureComponentType) {
        val components = componentRepository.findAllByType(type)
        val structureComponents = components.map {
            StructureComponent(0, structureId, it.id)
        }
        structureComponentRepository.saveAll(structureComponents)
    }

    fun refreshStructureComponents(structureId: String, type: StructureComponentType) {
        deleteAllByStructure(structureId)
        createForComponentType(structureId, type)
    }
}