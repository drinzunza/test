package com.uav_recon.app.api.repositories

import com.uav_recon.app.api.entities.db.Company
import com.uav_recon.app.api.entities.db.CompanyType
import com.uav_recon.app.api.entities.db.Project
import org.springframework.data.repository.CrudRepository

interface CompanyRepository : CrudRepository<Company, Long> {
    fun findFirstById(companyId: Long): Company?
    fun findFirstByDeletedIsFalseAndId(id: Long) : Company?
    fun findAllByDeletedIsFalseAndType(type: CompanyType) : List<Company>
}
