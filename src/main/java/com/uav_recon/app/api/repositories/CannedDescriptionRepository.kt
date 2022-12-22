package com.uav_recon.app.api.repositories

import com.uav_recon.app.api.entities.db.CannedDescription
import org.springframework.data.jpa.repository.JpaRepository

interface CannedDescriptionRepository : JpaRepository<CannedDescription, String> {
    fun findAllByComponentIdInAndSubcomponentIdInAndDefectIdIn(componentIds: List<String>, subcomponentIds: List<String>, defectIds: List<String>) : List<CannedDescription>
}