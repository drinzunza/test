package com.uav_recon.app.api.services

import com.uav_recon.app.api.entities.db.Photo
import com.uav_recon.app.api.entities.requests.bridge.LocationDto
import com.uav_recon.app.api.entities.requests.bridge.PhotoDto
import com.uav_recon.app.api.repositories.PhotoRepository
import org.springframework.stereotype.Service
import org.springframework.web.multipart.MultipartFile

@Service
class PhotoService(val photoRepository: PhotoRepository, val fileService: FileService) {

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

    fun PhotoDto.toEntity(createdBy: Int, updatedBy: Int, observationDefectId: String, link: String) = Photo(
        id = id,
        uuid = uuid,
        altitude = location?.altitude,
        longitude = location?.longitude,
        latitude = location?.longitude,
        drawables = drawables,
        observationDefectId = observationDefectId,
        link = link,
        createdBy = createdBy,
        updatedBy = updatedBy
    )

    fun findAllByObservationDefectIdAndNotDeleted(id: String): List<PhotoDto> {
        return photoRepository.findAllByObservationDefectIdAndDeletedIsFalse(id).map { p -> p.toDto() }
    }

    fun save(dto: PhotoDto,
             data: MultipartFile,
             inspectionId: String,
             observationId: String,
             observationDefectId: String,
             updatedBy:
             Int): PhotoDto {
        var createdBy = updatedBy
        val link: String?
        val optional = photoRepository.findById(dto.uuid)
        if (optional.isPresent) {
            val photo = optional.get()
            createdBy = photo.createdBy
            link = photo.link
        } else {
            val contentType = data.contentType
            val format = if (contentType.contains("/")) contentType.split("/")[1] else "jpg"
            link =
                    fileService.save(updatedBy,
                                     inspectionId,
                                     observationId,
                                     observationDefectId,
                                     dto.uuid,
                                     format,
                                     data.bytes)
        }

        dto.link = link
        return photoRepository.save(dto.toEntity(createdBy, updatedBy, observationDefectId, link)).toDto()
    }

}
