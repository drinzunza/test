package com.uav_recon.app.api.repositories

import com.uav_recon.app.api.entities.db.StructureComponent
import com.uav_recon.app.api.entities.db.SubcomponentDefect
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.CrudRepository

interface StructureComponentRepository : CrudRepository<StructureComponent, Int> {
    fun findAllByStructureId(structureId: String): List<StructureComponent>
    fun findAllByStructureIdIn(structureIds: List<String>): List<StructureComponent>
    fun findAllByComponentIdIn(componentIds: List<String>): List<StructureComponent>
    fun deleteByStructureId(structureId: String)
    fun deleteByStructureIdIn(ids: List<String>)
}