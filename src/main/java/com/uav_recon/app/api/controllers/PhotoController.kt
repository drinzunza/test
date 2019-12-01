package com.uav_recon.app.api.controllers

import com.fasterxml.jackson.databind.ObjectMapper
import com.uav_recon.app.api.entities.requests.bridge.LocationDto
import com.uav_recon.app.api.entities.requests.bridge.PhotoDto
import com.uav_recon.app.api.entities.requests.bridge.UpdatePhotoDto
import com.uav_recon.app.api.services.PhotoService
import com.uav_recon.app.configurations.ControllerConfiguration
import com.uav_recon.app.configurations.ControllerConfiguration.VERSION
import org.apache.commons.lang3.StringUtils
import org.slf4j.LoggerFactory
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.core.convert.converter.Converter
import org.springframework.format.annotation.DateTimeFormat
import org.springframework.http.ResponseEntity
import org.springframework.stereotype.Component
import org.springframework.web.bind.annotation.DeleteMapping
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.PutMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RequestHeader
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RequestParam
import org.springframework.web.bind.annotation.RestController
import org.springframework.web.multipart.MultipartFile
import java.time.OffsetDateTime


@RestController
@RequestMapping("${VERSION}/inspection/{inspectionId}/observation/{observationId}/observationDefect" +
                        "/{observationDefectId}/photo")
class PhotoController(private val photoService: PhotoService) : BaseController() {

    private val logger = LoggerFactory.getLogger(PhotoController::class.java)

    @PostMapping
    fun uploadPhoto(
            @RequestHeader(ControllerConfiguration.X_TOKEN) token: String,
            @PathVariable inspectionId: String,
            @PathVariable observationId: String,
            @PathVariable observationDefectId: String,
            @RequestParam name: String,
            @RequestParam uuid: String,
            @RequestParam location: LocationDto?,
            @RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm:ssXXX") createdAt: OffsetDateTime?,
            @RequestParam drawables: String?,
            @RequestParam data: MultipartFile): ResponseEntity<*> {
        return ResponseEntity.ok(photoService.save(PhotoDto(uuid, null, name, createdAt, location, drawables),
                                                   data,
                                                   inspectionId,
                                                   observationId,
                                                   observationDefectId,
                                                   getAuthenticatedUserId()))
    }

    @PutMapping("/{uuid}")
    fun update(@RequestHeader(ControllerConfiguration.X_TOKEN) token: String,
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

    @DeleteMapping("/{uuid}")
    fun delete(@RequestHeader(ControllerConfiguration.X_TOKEN) token: String,
               @PathVariable inspectionId: String,
               @PathVariable observationId: String,
               @PathVariable observationDefectId: String,
               @PathVariable uuid: String): ResponseEntity<*> {
        photoService.delete(inspectionId, observationId, observationDefectId, uuid)
        return ResponseEntity.ok(success)
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
