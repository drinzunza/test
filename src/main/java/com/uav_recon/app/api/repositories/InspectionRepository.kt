package com.uav_recon.app.api.repositories

import com.uav_recon.app.api.entities.db.Inspection
import org.springframework.data.jpa.repository.JpaRepository

interface InspectionRepository : JpaRepository<Inspection, String>
