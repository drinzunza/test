package com.uav_recon.app.api.repositories

import com.uav_recon.app.api.entities.db.ObservationName
import org.springframework.data.repository.CrudRepository

interface ObservationNameRepository : CrudRepository<ObservationName, String> {
    fun findAllByIdIn(ids: List<String>): List<ObservationName>
    fun findFirstById(id: String): ObservationName?
}