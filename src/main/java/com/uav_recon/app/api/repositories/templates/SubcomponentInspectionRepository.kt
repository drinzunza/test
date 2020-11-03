package com.uav_recon.app.api.repositories.templates

import com.uav_recon.app.api.entities.db.templates.SubcomponentInspection
import org.springframework.data.repository.CrudRepository

interface SubcomponentInspectionRepository : CrudRepository<SubcomponentInspection, Long> {
    fun findAllByInspectionId(inspectionId: String): List<SubcomponentInspection>
    fun findAllByInspectionIdIn(inspectionIds: List<String>): List<SubcomponentInspection>
    fun deleteByInspectionIdIn(inspectionIds: List<String>)
}