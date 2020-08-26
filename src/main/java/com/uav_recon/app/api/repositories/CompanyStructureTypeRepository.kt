package com.uav_recon.app.api.repositories

import com.uav_recon.app.api.entities.db.CompanyStructureType
import org.springframework.data.repository.CrudRepository

interface CompanyStructureTypeRepository : CrudRepository<CompanyStructureType, Long> {
    fun findAllByCompanyId(companyId: Long): List<CompanyStructureType>
    fun findAllByCompanyIdIn(companyIds: List<Long>): List<CompanyStructureType>
}