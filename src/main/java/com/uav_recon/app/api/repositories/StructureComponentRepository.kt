package com.uav_recon.app.api.repositories

import com.uav_recon.app.api.entities.db.StructureComponent
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.CrudRepository

interface StructureComponentRepository : CrudRepository<StructureComponent, Int> {
    @Query("SELECT s FROM StructureComponent s WHERE s.id > ?1")
    fun getValuesAfter(lastId: Int): List<StructureComponent>
}
