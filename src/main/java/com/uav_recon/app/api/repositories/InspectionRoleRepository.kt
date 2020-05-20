package com.uav_recon.app.api.repositories

import com.uav_recon.app.api.entities.db.InspectionRole
import org.springframework.data.repository.CrudRepository

interface InspectionRoleRepository : CrudRepository<InspectionRole, Int> {
    fun findAllByInspectionIdAndUserId(inspectionId: String, userId: Long) : List<InspectionRole>
    fun findAllByInspectionId(inspectionId: String) : List<InspectionRole>
    fun findAllByUserId(userId: Long) : List<InspectionRole>
}