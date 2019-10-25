package com.uav_recon.app.api.repositories

import com.uav_recon.app.api.entities.db.Subcomponent
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.CrudRepository

interface SubcomponentRepository : CrudRepository<Subcomponent, Int> {
    @Query("SELECT s FROM Subcomponent s WHERE s.id > ?1")
    fun getValuesAfter(lastId: Int): List<Subcomponent>
}