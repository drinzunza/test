package com.uav_recon.app.api.repositories

import com.uav_recon.app.api.entities.db.Component
import com.uav_recon.app.api.entities.db.StructureComponentType
import org.springframework.data.repository.CrudRepository

interface ComponentRepository : CrudRepository<Component, String> {
    fun findAllByIdIn(ids: List<String>): List<Component>
    fun findAllByIdInAndType(ids: List<String>, type: StructureComponentType): List<Component>
    fun findAllByCompanyId(companyId: Long): List<Component>
    fun findAllByType(type: StructureComponentType): List<Component>
    fun findFirstById(id: String): Component?
}