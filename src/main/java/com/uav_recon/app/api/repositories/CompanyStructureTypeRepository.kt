package com.uav_recon.app.api.repositories

import com.uav_recon.app.api.entities.db.CompanyStructureType
import org.springframework.data.repository.CrudRepository

interface CompanyStructureTypeRepository : CrudRepository<CompanyStructureType, Long> {
}