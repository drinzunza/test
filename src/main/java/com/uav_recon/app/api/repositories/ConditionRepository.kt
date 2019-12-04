package com.uav_recon.app.api.repositories

import com.uav_recon.app.api.entities.db.Condition
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.CrudRepository

interface ConditionRepository : CrudRepository<Condition, String> {
    fun findAllByDefectId(defectInt: String): List<Condition>
}