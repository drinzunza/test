package com.uav_recon.app.api.repositories

import com.uav_recon.app.api.entities.db.Inspector
import org.springframework.data.repository.CrudRepository

interface InspectorRepository : CrudRepository<Inspector, Int>