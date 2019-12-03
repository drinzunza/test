package com.uav_recon.app.api.services

import com.uav_recon.app.api.entities.db.Photo
import com.uav_recon.app.api.entities.requests.bridge.LocationDto
import com.uav_recon.app.api.entities.requests.bridge.PhotoDto
import com.uav_recon.app.api.entities.requests.bridge.UpdatePhotoDto
import com.uav_recon.app.api.repositories.InspectionRepository
import com.uav_recon.app.api.repositories.ObservationDefectRepository
import com.uav_recon.app.api.repositories.ObservationRepository
import com.uav_recon.app.api.repositories.PhotoRepository
import com.uav_recon.app.configurations.UavConfiguration
import org.springframework.stereotype.Service
import org.springframework.web.multipart.MultipartFile

@Service
class PhotoService(val photoRepository: PhotoRepository,
                   val configuration: UavConfiguration,
                   val fileService: FileService,
                   val observationDefectRepository: ObservationDefectRepository,
                   val observationRepository: ObservationRepository,
                   val inspectionRepository: InspectionRepository) {

    fun Photo.toDto() = PhotoDto(
        uuid = uuid,
        name = name,
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
        uuid = uuid,
        name = name,
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

    @Throws(Error::class)
    fun update(uuid: String,
               updateDto: UpdatePhotoDto,
               inspectionId: String,
               observationId: String,
               observationDefectId: String,
               updatedBy: Int) {
        //checkRelationship(inspectionId, observationId, observationDefectId)
        val optional = photoRepository.findById(uuid)
        if (!optional.isPresent) {
            throw Error(105, "Invalid photo uuid")
        }
        val photo = optional.get()
        photo.drawables = updateDto.drawables
        photoRepository.save(photo)
    }

    @Throws(Error::class)
    fun save(dto: PhotoDto,
             data: MultipartFile,
             inspectionId: String,
             observationId: String,
             observationDefectId: String,
             updatedBy: Int): PhotoDto {
        //checkRelationship(inspectionId, observationId, observationDefectId)
        var createdBy = updatedBy
        val link: String?
        val optional = photoRepository.findById(dto.uuid)
        if (optional.isPresent) {
            val photo = optional.get()
            createdBy = photo.createdBy
            link = photo.link
        } else {
            val format = getFileFormat(data.contentType)
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

    @Throws(Error::class)
    fun delete(inspectionId: String,
               observationId: String,
               observationDefectId: String,
               uuid: String) {
        //checkRelationship(inspectionId, observationId, observationDefectId)
        val optional = photoRepository.findByUuidAndObservationDefectIdAndDeletedIsFalse(uuid, observationDefectId);
        if (!optional.isPresent) {
            throw Error(105, "Invalid photo uuid")
        }
        val photo = optional.get()
        if (configuration.files.removeFileOnDelete == "true") {
            fileService.delete(photo.link)
        }
        photo.deleted = true
        photoRepository.save(photo)
    }

    fun checkRelationship(inspectionId: String,
                          observationId: String,
                          observationDefectId: String) {
        if (!inspectionRepository.findByUuidAndDeletedIsFalse(inspectionId).isPresent) {
            throw Error(101, "Invalid inspection UUID")
        }
        if (!observationRepository.findByUuidAndInspectionIdAndDeletedIsFalse(observationId, inspectionId).isPresent) {
            throw Error(102, "Invalid observation UUID")
        }

        if (!observationDefectRepository.findByUuidAndObservationIdAndDeletedIsFalse(observationDefectId,
                                                                                     observationId).isPresent) {
            throw Error(102, "Invalid observation defect UUID")
        }
    }

    private fun getFileFormat(contentType: String?) =
            if (contentType != null && contentType.contains("/")) contentType.split("/")[1] else "jpg"

}
