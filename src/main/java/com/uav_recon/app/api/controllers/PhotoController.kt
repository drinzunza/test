package com.uav_recon.app.api.controllers

import com.fasterxml.jackson.databind.ObjectMapper
import com.uav_recon.app.api.entities.requests.bridge.*
import com.uav_recon.app.api.services.PhotoService
import com.uav_recon.app.configurations.ControllerConfiguration
import com.uav_recon.app.configurations.ControllerConfiguration.VERSION
import com.uav_recon.app.configurations.ControllerConfiguration.VERSION2
import com.uav_recon.app.configurations.ControllerConfiguration.X_TOKEN
import org.apache.commons.lang3.StringUtils
import org.slf4j.LoggerFactory
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.core.convert.converter.Converter
import org.springframework.format.annotation.DateTimeFormat
import org.springframework.http.ResponseEntity
import org.springframework.stereotype.Component
import org.springframework.web.bind.annotation.*
import org.springframework.web.multipart.MultipartFile
import java.time.OffsetDateTime

@RestController
class PhotoController(private val photoService: PhotoService) : BaseController() {

    private val logger = LoggerFactory.getLogger(PhotoController::class.java)

    @PostMapping("${VERSION}/inspection/{inspectionId}/observation/{observationId}/observationDefect/{observationDefectId}/photo")
    fun uploadPhoto(
            @RequestHeader(X_TOKEN) token: String,
            @PathVariable inspectionId: String,
            @PathVariable observationId: String,
            @PathVariable observationDefectId: String,
            @RequestParam name: String,
            @RequestParam uuid: String,
            @RequestParam location: LocationDto?,
            @RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss.SSSXXX") createdAt: OffsetDateTime?,
            @RequestParam drawables: String?,
            @RequestParam data: Array<MultipartFile>): ResponseEntity<PhotoDto> {
        return ResponseEntity.ok(photoService.save(PhotoDto(uuid, null, null, null, name, createdAt, location, drawables, observationDefectId),
                                                   data,
                                                   inspectionId,
                                                   observationId,
                                                   observationDefectId,
                                                   getAuthenticatedUserId()))
    }

    @PostMapping("${VERSION2}/inspection/{inspectionId}/observation/{observationId}/observationDefect/{observationDefectId}/photo")
    fun uploadPhoto2(
        @RequestHeader(X_TOKEN) token: String,
        @PathVariable inspectionId: String,
        @PathVariable observationId: String,
        @PathVariable observationDefectId: String,
        @RequestParam name: String,
        @RequestParam uuid: String,
        @RequestParam latitude: Double?,
        @RequestParam longitude: Double?,
        @RequestParam altitude: Double?,
        @RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss.SSSXXX") createdAt: OffsetDateTime?,
        @RequestParam drawables: String?,
        @RequestParam data: Array<MultipartFile>): ResponseEntity<PhotoDto> {
        val location = LocationDto(latitude, longitude, altitude)
        return ResponseEntity.ok(photoService.save(PhotoDto(uuid, null, null, null, name, createdAt, location, drawables, observationId),
            data,
            inspectionId,
            observationId,
            observationDefectId,
            getAuthenticatedUserId()))
    }

    @PostMapping("${VERSION}/photo/{uuid}")
    fun updateAnnotatedPhoto(@RequestHeader(X_TOKEN) token: String,
                    @PathVariable uuid: String,
                    @RequestParam data: MultipartFile
    ): ResponseEntity<PhotoDto> {
        return ResponseEntity.ok(photoService.updateAnnotatedPhoto(uuid, data, getAuthenticatedUserId()))
    }

    @PutMapping("${VERSION}/inspection/{inspectionId}/observation/{observationId}/observationDefect/{observationDefectId}/photo/{uuid}")
    fun update(@RequestHeader(X_TOKEN) token: String,
               @PathVariable inspectionId: String,
               @PathVariable observationId: String,
               @PathVariable observationDefectId: String,
               @PathVariable uuid: String,
               @RequestBody updateDto: UpdatePhotoDto): ResponseEntity<*> {
        photoService.update(uuid,
                            updateDto,
                            inspectionId,
                            observationId,
                            observationDefectId,
                            getAuthenticatedUserId())
        return ResponseEntity.ok(success)
    }

    @PatchMapping("${VERSION}/photo/{uuid}")
    fun updatePhoto(@RequestHeader(X_TOKEN) token: String,
               @PathVariable uuid: String,
               @RequestBody body: PhotoUpdateDto
    ): ResponseEntity<PhotoDto> {
        return ResponseEntity.ok(photoService.updatePhoto(getAuthenticatedUser(), uuid, body))
    }

    @DeleteMapping("${VERSION}/inspection/{inspectionId}/observation/{observationId}/observationDefect/{observationDefectId}/photo/{uuid}")
    fun delete(@RequestHeader(X_TOKEN) token: String,
               @PathVariable inspectionId: String,
               @PathVariable observationId: String,
               @PathVariable observationDefectId: String,
               @PathVariable uuid: String): ResponseEntity<*> {
        photoService.delete(inspectionId, observationId, observationDefectId, uuid)
        return ResponseEntity.ok(success)
    }

    @GetMapping("$VERSION/photos/{inspectionId}/{observationId}/{observationDefectDisplayId}")
    fun getPhotos(@RequestHeader(X_TOKEN) token: String,
                  @PathVariable inspectionId: String,
                  @PathVariable observationId: String,
                  @PathVariable observationDefectDisplayId: String
    ): ResponseEntity<List<PhotoDto>> {
        return ResponseEntity.ok(photoService.getPhotosDto(inspectionId, observationId, observationDefectDisplayId))
    }

    @Component
    class StringToLocationConverter : Converter<String, LocationDto> {

        @Autowired
        private val objectMapper: ObjectMapper? = null

        override fun convert(source: String): LocationDto? {
            if (StringUtils.isBlank(source)) {
                return null
            }
            return objectMapper!!.readValue(source, LocationDto::class.java)
        }
    }
}
