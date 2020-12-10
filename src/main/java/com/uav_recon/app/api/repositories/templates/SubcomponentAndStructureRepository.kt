package com.uav_recon.app.api.repositories.templates

import com.uav_recon.app.api.entities.db.templates.SubcomponentAndStructure
import org.springframework.data.repository.CrudRepository

interface SubcomponentAndStructureRepository : CrudRepository<SubcomponentAndStructure, Long> {
    fun findAllByStructureId(structureId: String): List<SubcomponentAndStructure>
    fun findAllByStructureIdIn(structureIds: List<String>): List<SubcomponentAndStructure>
    fun deleteByStructureIdIn(structureIds: List<String>)
}