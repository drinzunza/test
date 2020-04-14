package com.uav_recon.app.api.repositories

import com.uav_recon.app.api.entities.db.Condition
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.CrudRepository

interface ConditionRepository : CrudRepository<Condition, String> {
    fun findAllByDefectIdIn(defectIds: List<String>): List<Condition>
    fun findAllByDefectId(defectInt: String): List<Condition>
    fun findAllByIdIn(ids: List<String>): List<Condition>
    fun findAllByIdInAndIdContains(ids: List<String>, buildType: String): List<Condition>
    fun findAllByIdContains(buildType: String): List<Condition>
    fun findFirstById(id: String): Condition?
}