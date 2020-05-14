package com.uav_recon.app.api.repositories

import com.uav_recon.app.api.entities.db.Company
import org.springframework.data.repository.CrudRepository

interface CompanyRepository : CrudRepository<Company, Long> {
    fun findFirstById(companyId: Long): Company?
}
