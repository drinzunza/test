package com.uav_recon.app.api.repositories

import com.uav_recon.app.api.entities.db.Inspection
import org.springframework.data.jpa.repository.JpaRepository
import java.util.*

interface InspectionRepository : JpaRepository<Inspection, String> {
    fun findAllByUuidIn(ids: List<String>) : List<Inspection>
    fun findAllByProjectIdInOrCreatedByInOrUuidIn(projectIds: List<Long>, createdIds: List<Int>, ids: List<String>) : List<Inspection>
    fun findAllByDeletedIsFalseAndProjectId(projectId: Long) : List<Inspection>
    fun findAllByDeletedIsFalseAndProjectIdIn(ids: List<Long>) : List<Inspection>
    fun findAllByDeletedIsFalseAndStructureIdIn(ids: List<String>) : List<Inspection>
    fun findAllByDeletedIsFalseAndCreatedBy(userId: Int) : List<Inspection>
    fun findAllByDeletedIsFalseAndCreatedByIn(ids: List<Int>) : List<Inspection>
    fun findAllByDeletedIsFalseAndUuidInAndCreatedByIn(ids: List<String>, userIds: List<Int>) : List<Inspection>
    fun findAllByUuidInOrCreatedByIn(ids: List<String>, userIds: List<Int>) : List<Inspection>
    fun findAllByDeletedIsFalseAndUuidIn(ids: List<String>) : List<Inspection>
    fun findByUuidAndDeletedIsFalse(id: String) : Optional<Inspection>
    fun findFirstByUuidAndDeletedIsFalse(id: String) : Inspection?
    fun findFirstByUuid(id: String) : Inspection?
}
