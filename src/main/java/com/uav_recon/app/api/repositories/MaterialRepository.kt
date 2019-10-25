package com.uav_recon.app.api.repositories

import com.uav_recon.app.api.entities.db.Material
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.CrudRepository

interface MaterialRepository : CrudRepository<Material, Int> {
    @Query("SELECT m FROM Material m WHERE m.id > ?1")
    fun getValuesAfter(lastId: Int): List<Material>
}