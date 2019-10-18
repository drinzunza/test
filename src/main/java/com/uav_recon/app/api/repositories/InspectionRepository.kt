package com.uav_recon.app.api.repositories

import com.uav_recon.app.api.entities.db.Inspection
import org.springframework.data.repository.CrudRepository

interface InspectionRepository : CrudRepository<Inspection, Int>