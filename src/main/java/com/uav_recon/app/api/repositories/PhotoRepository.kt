package com.uav_recon.app.api.repositories

import com.uav_recon.app.api.entities.db.Photo
import org.springframework.data.repository.CrudRepository
import java.util.*

interface PhotoRepository : CrudRepository<Photo, String> {
    fun findFirstByUuid(uuid: String): Photo?
    fun findAllByObservationDefectIdAndDeletedIsFalse(observationDefectId: String): List<Photo>
    fun findAllByObservationDefectIdInAndDeletedIsFalse(observationDefectIds: List<String>): List<Photo>
    fun findAllByDeletedIsFalseAndObservationDefectIdIn(ids: List<String>): List<Photo>
    fun findByUuidAndObservationDefectIdAndDeletedIsFalse(uuid: String, observationDefectId: String): Optional<Photo>
    fun findAllByNameAndObservationDefectId(name: String, observationDefectId: String): List<Photo>
    fun countByObservationDefectIdAndDeletedIsFalse(observationDefectId: String): Long
    fun findByObservationDefectIdAndLink(observationDefectId: String, link: String): Photo?
}
