package com.uav_recon.app.api.services

import com.google.common.io.Files
import com.uav_recon.app.api.entities.db.ObservationDefectStatus
import com.uav_recon.app.api.entities.db.Photo
import com.uav_recon.app.api.entities.db.User
import com.uav_recon.app.api.entities.db.update
import com.uav_recon.app.api.entities.requests.bridge.LocationDto
import com.uav_recon.app.api.entities.requests.bridge.PhotoDto
import com.uav_recon.app.api.entities.requests.bridge.PhotoUpdateDto
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
import java.util.UUID

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
        observationDefectId = observationDefectId,
        createdAt = createdAtClient,
        link = fileService.generateSignedLink(link),
        thumbLink = fileService.generateSignedLink(getThumbnailLink(this)),
        annotatedLink = fileService.generateSignedLink(getAnnotatedLink(this)),
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

    fun clonePhoto(sourcePhotoDto: PhotoDto, observationDefectId: String, createdBy: Int, updatedBy: Int,
                   createdAtClient: OffsetDateTime?): PhotoDto {
        val clonedPhoto = Photo(
            uuid = UUID.randomUUID().toString(),
            name = sourcePhotoDto.name,
            altitude = sourcePhotoDto.location?.altitude,
            longitude = sourcePhotoDto.location?.longitude,
            latitude = sourcePhotoDto.location?.latitude,
            drawables = sourcePhotoDto.drawables,
            observationDefectId = observationDefectId,
            link = sourcePhotoDto.link ?: "",
            createdBy = createdBy,
            updatedBy = updatedBy,
            createdAtClient = createdAtClient ?: OffsetDateTime.now()
        )
        return photoRepository.save(clonedPhoto).toDto()
    }

    fun findAllByObservationDefectIdAndNotDeleted(id: String): List<PhotoDto> {
        return photoRepository.findAllByObservationDefectIdAndDeletedIsFalse(id).map { p -> p.toDto() }
    }

    fun findAllByObservationDefectIdAndNotDeleted(ids: List<String>): List<PhotoDto> {
        return photoRepository.findAllByObservationDefectIdInAndDeletedIsFalse(ids).map { p -> p.toDto() }
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
        fileService.regenerateRectImages(photo)
        photoRepository.save(photo)
        saveWeather(photo)

        // set unchanged cloned observation defects to changed
        val observationDefect = observationDefectRepository.findFirstByUuid(observationDefectId)
        if (observationDefect?.status == ObservationDefectStatus.UNCHANGED && observationDefect.previousDefectNumber != null) {
            observationDefect.status = ObservationDefectStatus.CHANGED
        }
        observationDefectRepository.save(observationDefect)
    }

    fun updatePhoto(user: User, uuid: String, dto: PhotoUpdateDto): PhotoDto {
        val photo = photoRepository.findFirstByUuid(uuid)
            ?: throw Error(105, "Invalid photo uuid")
        photo.update(dto)
        fileService.regenerateRectImages(photo)

        // set unchanged cloned observation defects to changed
        val observationDefect = observationDefectRepository.findFirstByUuid(photo.observationDefectId)
        if (observationDefect?.status == ObservationDefectStatus.UNCHANGED && observationDefect.previousDefectNumber != null) {
            observationDefect.status = ObservationDefectStatus.CHANGED
        }
        observationDefectRepository.save(observationDefect)

        return photoRepository.save(photo).toDto()
    }

    fun updateAnnotatedPhoto(
        uuid: String,
        data: MultipartFile,
        updatedBy: Int
    ): PhotoDto {
        val photo = photoRepository.findFirstByUuid(uuid)
            ?: throw Error(105, "Invalid photo uuid")
        val observationDefectId = photo.observationDefectId
        val observationDefect = observationDefectRepository.findFirstByUuid(observationDefectId)
            ?: throw Error(105, "Observation defect not found")
        val observation = observationRepository.findFirstByUuid(observationDefect.observationId)
            ?: throw Error(105, "Observation not found")

        val format = getFileFormat(data!!.contentType)
        val annotatedPhotoFormat = getFileFormat(data!!.contentType)
        val annotatedPhotoLink = fileService.saveAnnotatedPhoto(
            updatedBy,
            observation.inspectionId,
            observationDefect.observationId,
            observationDefectId,
            uuid,
            annotatedPhotoFormat,
            data.bytes
        )

        // set unchanged cloned observation defects to changed
        if (observationDefect?.status == ObservationDefectStatus.UNCHANGED && observationDefect.previousDefectNumber != null) {
            observationDefect.status = ObservationDefectStatus.CHANGED
        }
        observationDefectRepository.save(observationDefect)

        val photoDto = photo.toDto()
        photoDto.annotatedLink = annotatedPhotoLink
        return photoDto
    }

    @Throws(Error::class)
    fun save(dto: PhotoDto,
             data: Array<MultipartFile>,
             inspectionId: String,
             observationId: String,
             observationDefectId: String,
             updatedBy: Int
    ): PhotoDto {
        logger.info("Saving photo ${dto.uuid}, ${dto.name}, ${dto.drawables}, ${dto.location?.latitude}x${dto.location?.longitude}")

        val originalPhotoData = data.getOrNull(0)
        val annotatedPhotoData = data.getOrNull(1)

        //checkRelationship(inspectionId, observationId, observationDefectId)
        var createdBy = updatedBy
        val link: String?
        val annotatedPhotoLink: String?
        val createdAtClient: OffsetDateTime?
        var name = dto.name
        val optional = photoRepository.findById(dto.uuid)
        if (optional.isPresent) {
            val photo = optional.get()
            createdBy = photo.createdBy
            link = photo.link
            dto.name = photo.name
            createdAtClient = photo.createdAtClient
            logger.info("Photo ${dto.uuid} exists")
        } else {
            logger.info("Photo ${dto.uuid} not exists")
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

            val format = getFileFormat(originalPhotoData!!.contentType)
            link = fileService.save(updatedBy, inspectionId, observationId, observationDefectId,
                    dto.uuid, dto.drawables, format, originalPhotoData.bytes)
            annotatedPhotoLink = fileService.saveAnnotatedPhoto(
                updatedBy, inspectionId, observationId,
                observationDefectId, dto.uuid, format, annotatedPhotoData!!.bytes
            )
            logger.info("Photo ${dto.uuid} saved with link $link")
        }

        dto.link = link
        dto.name = name
        val photo = dto.toEntity(createdBy, updatedBy, observationDefectId, link, createdAtClient)
        saveWeather(photo)

        // set unchanged cloned observation defects to changed
        val observationDefect = observationDefectRepository.findFirstByUuid(observationDefectId)
        if (observationDefect?.status == ObservationDefectStatus.UNCHANGED && observationDefect.previousDefectNumber != null) {
            observationDefect.status = ObservationDefectStatus.CHANGED
        }
        observationDefectRepository.save(observationDefect)

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
                logger.info("Photo defect weather already set or null (id=${observationDefect?.id}, temp=${observationDefect?.temperature})")
            }
        } else {
            logger.info("No latitude for weather")
        }
    }

    fun getPhotosDto(inspectionId: String, observationId: String, observationDefectDisplayId: String): List<PhotoDto> {
        val defect = observationDefectRepository
                .findFirstByObservationIdAndIdAndDeletedIsFalse(observationId, observationDefectDisplayId)
        if (defect != null) {
            val photos = photoRepository.findAllByObservationDefectIdAndDeletedIsFalse(defect.uuid)
            return photos.map { p -> p.toDto() }
        }
        return listOf()
    }

    fun getThumbnailLink(photo: Photo): String {
        val splitted = photo.link.split('.')
        val name = splitted.getOrNull(splitted.size - 2)
        return name?.let { photo.link.replace(name, "${name}_rect_thumb") } ?: photo.link
    }

    fun getAnnotatedLink(photo: Photo): String {
        val splitted = photo.link.split('.')
        val name = splitted.getOrNull(splitted.size - 2)
        return name?.let { photo.link.replace(name, "${name}_rect") } ?: photo.link
    }

    private fun getFileFormat(contentType: String?): String {
        var fileFormat = if (contentType != null && contentType.contains("/")) contentType.split("/")[1] else "jpeg"

        if (fileFormat == "octet-stream") {
            // assume it is an image
            fileFormat = "jpeg"
        }

        return fileFormat
    }
}
