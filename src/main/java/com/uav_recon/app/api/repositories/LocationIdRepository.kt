package com.uav_recon.app.api.repositories

import com.uav_recon.app.api.entities.db.LocationId
import org.springframework.data.repository.CrudRepository

interface LocationIdRepository : CrudRepository<LocationId, String> {
    fun findAllByIdIn(ids: List<String>): List<LocationId>
    fun findAllByIdInAndIdContains(ids: List<String>, buildType: String): List<LocationId>
    fun findAllByIdContains(buildType: String): List<LocationId>
}