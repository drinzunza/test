package com.uav_recon.app.api.repositories

import com.uav_recon.app.api.entities.db.Etag
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.CrudRepository

interface EtagRepository : CrudRepository<Etag, String> {
    fun findFirstByHash(hash: String): Etag?
    fun findTopByOrderByIdDesc(): Etag?
    @Query("select e from Etag e where e.id > ?1")
    fun findAllSinceEtagId(id: Int): List<Etag>
}