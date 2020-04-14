package com.uav_recon.app.api.repositories

import com.uav_recon.app.api.entities.db.Company
import org.springframework.data.jpa.repository.JpaRepository
import java.util.*

interface CompanyRepository : JpaRepository<Company, Long> {
    fun findFirstById(companyId: Long): Company?
}
