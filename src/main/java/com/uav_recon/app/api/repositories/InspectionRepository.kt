package com.uav_recon.app.api.repositories

import com.uav_recon.app.api.entities.db.Inspection
import org.springframework.data.jpa.repository.JpaRepository
import java.util.*

interface InspectionRepository : JpaRepository<Inspection, String> {
    fun findAllByDeletedIsFalse() : List<Inspection>
    fun findByIdAndDeletedIsFalse(id: String) : Optional<Inspection>
}
