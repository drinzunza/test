package com.uav_recon.app.api.repositories

import com.uav_recon.app.api.entities.db.Subcomponent
import org.springframework.data.repository.CrudRepository

interface SubcomponentRepository : CrudRepository<Subcomponent, String> {
    fun findAllByComponentIdIn(componentIds: List<String>): List<Subcomponent>
    fun findAllByComponentId(componentId: String): List<Subcomponent>
    fun findAllByIdIn(ids: List<String>): List<Subcomponent>
    fun findAllByIdInAndIdContains(ids: List<String>, buildType: String): List<Subcomponent>
    fun findAllByIdContains(buildType: String): List<Subcomponent>
    fun findFirstById(id: String): Subcomponent?
}