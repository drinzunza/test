package com.uav_recon.app.api.services

import com.uav_recon.app.api.entities.db.Photo
import com.uav_recon.app.api.entities.requests.bridge.LocationDto
import com.uav_recon.app.api.entities.requests.bridge.PhotoDto
import com.uav_recon.app.api.repositories.PhotoRepository
import org.springframework.stereotype.Service

@Service
class PhotoService(val photoRepository: PhotoRepository) {

    fun Photo.toDto() = PhotoDto(
        id = id,
        uuid = uuid,
        createdAt = createdAt,
        link = link,
        location = LocationDto(
            latitude,
            longitude,
            altitude
        ),
        drawables = drawables
    )

    fun findAllByObservationDefectIdAndNotDeleted(id: String): List<PhotoDto> {
        return photoRepository.findAllByObservationDefectIdAndDeletedIsFalse(id).map { p -> p.toDto() }
    }

}
