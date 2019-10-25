package com.uav_recon.app.api.repositories

import com.uav_recon.app.api.entities.db.StructuralComponent
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.CrudRepository

interface StructuralComponentRepository : CrudRepository<StructuralComponent, Int> {
    @Query("SELECT s FROM StructuralComponent s WHERE s.id > ?1")
    fun getValuesAfter(lastId: Int): List<StructuralComponent>
}