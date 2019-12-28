package com.uav_recon.app.api.repositories

import com.uav_recon.app.api.entities.db.Inspection
import org.springframework.data.jpa.repository.JpaRepository
import java.util.*

interface InspectionRepository : JpaRepository<Inspection, String> {
    fun findAllByDeletedIsFalseAndCreatedBy(userId: Int) : List<Inspection>
    fun findByUuidAndDeletedIsFalse(id: String) : Optional<Inspection>
    fun findFirstByUuidAndDeletedIsFalse(id: String) : Inspection?
}
