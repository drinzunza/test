package com.uav_recon.app.api.repositories

import com.uav_recon.app.api.entities.db.Report
import org.springframework.data.repository.CrudRepository

interface ReportRepository : CrudRepository<Report, String> {
    fun findAllByInspectionId(inspectionId: String): List<Report>
}