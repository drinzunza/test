package com.uav_recon.app.api.repositories

import com.uav_recon.app.api.entities.db.Condition
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.CrudRepository

interface ConditionRepository : CrudRepository<Condition, Int> {
    @Query("SELECT c FROM Condition c WHERE c.id > ?1")
    fun getValuesAfter(lastId: Int): List<Condition>
}