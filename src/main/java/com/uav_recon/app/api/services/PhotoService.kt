package com.uav_recon.app.api.services

import com.google.common.io.Files
import com.uav_recon.app.api.entities.db.Photo
import com.uav_recon.app.api.entities.requests.bridge.LocationDto
import com.uav_recon.app.api.entities.requests.bridge.PhotoDto
import com.uav_recon.app.api.entities.requests.bridge.UpdatePhotoDto
import com.uav_recon.app.api.repositories.InspectionRepository
import com.uav_recon.app.api.repositories.ObservationDefectRepository
import com.uav_recon.app.api.repositories.ObservationRepository
import com.uav_recon.app.api.repositories.PhotoRepository
import com.uav_recon.app.configurations.UavConfiguration
import org.slf4j.LoggerFactory
import org.springframework.stereotype.Service
import org.springframework.web.multipart.MultipartFile
import java.time.OffsetDateTime

@Service
class PhotoService(
        private val photoRepository: PhotoRepository,
        private val configuration: UavConfiguration,
        private val fileService: FileService,
        private val observationDefectRepository: ObservationDefectRepository,
        private val observationRepository: ObservationRepository,
        private val inspectionRepository: InspectionRepository,
        private val weatherService: WeatherService
) {

    private val logger = LoggerFactory.getLogger(PhotoService::class.java)

    fun Photo.toDto() = PhotoDto(
        uuid = uuid,
        name = name,
        createdAt = createdAtClient,
        link = link,
        location = LocationDto(
            latitude,
            longitude,
            altitude
        ),
        drawables = drawables
    )

    fun PhotoDto.toEntity(createdBy: Int, updatedBy: Int, observationDefectId: String, link: String,
                          createdAtClient: OffsetDateTime?) = Photo(
        uuid = uuid,
        name = name,
        altitude = location?.altitude,
        longitude = location?.longitude,
        latitude = location?.latitude,
        drawables = drawables,
        observationDefectId = observationDefectId,
        link = link,
        createdBy = createdBy,
        updatedBy = updatedBy,
        createdAtClient = createdAtClient
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
        saveWeather(photo)
    }

    @Throws(Error::class)
    fun save(dto: PhotoDto,
             data: MultipartFile,
             inspectionId: String,
             observationId: String,
             observationDefectId: String,
             updatedBy: Int
    ): PhotoDto {
        //checkRelationship(inspectionId, observationId, observationDefectId)
        var createdBy = updatedBy
        val link: String?
        val createdAtClient: OffsetDateTime?
        var name = dto.name
        val optional = photoRepository.findById(dto.uuid)
        if (optional.isPresent) {
            val photo = optional.get()
            createdBy = photo.createdBy
            link = photo.link
            dto.name = photo.name
            createdAtClient = photo.createdAtClient
        } else {
            createdAtClient = dto.createdAt ?: OffsetDateTime.now()
            if (!dto.name.isNullOrBlank() && photoRepository
                            .findAllByNameAndObservationDefectId(dto.name!!, observationDefectId).isNotEmpty()) {
                val extension = Files.getFileExtension(dto.name)
                if (extension.isNotBlank()) {
                    name = "${Files.getNameWithoutExtension(dto.name)}_${createdAtClient!!.toEpochSecond()}.${extension}"
                } else {
                    name = "${dto.name}_${createdAtClient!!.toEpochSecond()}"
                }
            }

            val format = getFileFormat(data.contentType)
            link = fileService.save(updatedBy, inspectionId, observationId, observationDefectId,
                    dto.uuid, dto.drawables, format, data.bytes)
        }

        dto.link = link
        dto.name = name
        val photo = dto.toEntity(createdBy, updatedBy, observationDefectId, link, createdAtClient)
        saveWeather(photo)
        return photoRepository.save(photo).toDto()
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

    fun saveWeather(photo: Photo?) {
        if (photo?.latitude != null) {
            val observationDefect = observationDefectRepository
                    .findFirstByUuidAndDeletedIsFalse(photo.observationDefectId)

            if (observationDefect != null && observationDefect.temperature == null) {
                val weather = weatherService.getHistoricalWeather(
                        photo.latitude, photo.longitude, photo.createdAtClient?.toEpochSecond()
                )
                if (weather != null) {
                    logger.info("Save photo weather ${photo.latitude}:${photo.longitude}, " +
                            "${photo.createdAtClient}, ${weather.temperature}, ${weather.humidity}, ${weather.wind}")
                    observationDefect.temperature = weather.temperature
                    observationDefect.humidity = weather.humidity
                    observationDefect.wind = weather.wind
                    observationDefectRepository.save(observationDefect)
                }
            } else {
                logger.info("Photo defect weather already set or null ($observationDefect, ${observationDefect?.temperature})")
            }
        }
    }

    private fun getFileFormat(contentType: String?) =
            if (contentType != null && contentType.contains("/")) contentType.split("/")[1] else "jpg"

}
