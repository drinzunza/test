package com.uav_recon.app.api.repositories

import com.uav_recon.app.api.entities.db.StructureType
import org.springframework.data.repository.CrudRepository

interface StructureTypeRepository : CrudRepository<StructureType, Long> {
}