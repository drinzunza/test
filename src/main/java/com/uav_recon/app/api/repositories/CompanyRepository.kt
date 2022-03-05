package com.uav_recon.app.api.repositories

import com.uav_recon.app.api.entities.db.Company
import com.uav_recon.app.api.entities.db.CompanyType
import org.springframework.data.repository.CrudRepository

interface CompanyRepository : CrudRepository<Company, Long> {
    fun findFirstById(companyId: Long): Company?
    fun findFirstByDeletedIsFalseAndId(id: Long) : Company?
    fun findAllByDeletedIsFalseAndIdIn(ids: List<Long>): List<Company>
    fun findAllByDeletedIsFalseAndType(type: CompanyType) : List<Company>
    fun findAllByDeletedIsFalseAndTypeAndCreatorCompanyId(type: CompanyType, creatorCompanyId: Long) : List<Company>
    fun findAllByDeletedIsFalseAndCreatorCompanyId(creatorCompanyId: Long) : List<Company>
}
