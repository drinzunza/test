package com.uav_recon.app.api.repositories

import com.uav_recon.app.api.entities.db.Etag
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.CrudRepository

interface EtagRepository : CrudRepository<Etag, String> {
    fun findFirstByHashAndCompanyId(hash: String, companyId: Long): Etag?
    fun findTopByCompanyIdOrderByIdDesc(companyId: Long): Etag?
    @Query("select e from Etag e where e.id > ?1 and e.companyId = ?2")
    fun findAllSinceEtagIdWithCompanyId(id: Int, companyId: Long): List<Etag>
}