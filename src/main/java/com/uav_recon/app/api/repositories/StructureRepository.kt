package com.uav_recon.app.api.repositories

import com.uav_recon.app.api.entities.db.Structure
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.CrudRepository

interface StructureRepository : CrudRepository<Structure, Int> {
    @Query("SELECT s FROM Structure s WHERE s.id > ?1")
    fun getValuesAfter(lastId: Int): List<Structure>
}