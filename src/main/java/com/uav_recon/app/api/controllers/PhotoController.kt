package com.uav_recon.app.api.controllers

import com.uav_recon.app.api.entities.db.Photo
import com.uav_recon.app.api.entities.requests.photo.PhotoRequest
import com.uav_recon.app.api.entities.responses.Response
import com.uav_recon.app.api.entities.responses.UploadFileResponse
import com.uav_recon.app.api.entities.responses.photo.PhotoResponse
import com.uav_recon.app.api.repositories.ObservationDefectRepository
import com.uav_recon.app.api.repositories.PhotoRepository
import com.uav_recon.app.api.services.FileStorageService
import com.uav_recon.app.api.utils.response
import com.uav_recon.app.configurations.ControllerConfiguration.VERSION
import org.slf4j.LoggerFactory
import org.springframework.core.io.Resource
import org.springframework.data.repository.findByIdOrNull
import org.springframework.http.HttpHeaders
import org.springframework.http.MediaType
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*
import org.springframework.web.multipart.MultipartFile
import org.springframework.web.servlet.support.ServletUriComponentsBuilder
import java.io.IOException
import java.util.*
import javax.servlet.http.HttpServletRequest

@RestController
class PhotoController(
        private val fileStorageService: FileStorageService,
        private val photoRepository: PhotoRepository,
        private val observationDefectRepository: ObservationDefectRepository
) {

    private val logger = LoggerFactory.getLogger(PhotoController::class.java)

    @PostMapping("${VERSION}/photo")
    fun uploadPhoto(
            @RequestParam("latitude") latitude: Double,
            @RequestParam("longitude") longitude: Double,
            @RequestParam("altitude") altitude: Double,
            @RequestParam("startX") startX: Double,
            @RequestParam("startY") startY: Double,
            @RequestParam("endX") endX: Double,
            @RequestParam("endY") endY: Double,
            @RequestParam("observationDefectId") observationDefectId: Int,
            @RequestParam("file") file: MultipartFile
    ): Response<Photo> {
        // TODO add unique file name
        val fileName = fileStorageService.storeFile(file)

        val photo = Photo()
        photo.file = fileName
        photo.latitude = latitude
        photo.longitude = longitude
        photo.altitude = altitude
        photo.startX = startX
        photo.startY = startY
        photo.endX = endX
        photo.endY = endY
        photo.createdDate = Date()
        photo.observationDefect = observationDefectRepository.findByIdOrNull(observationDefectId)

        val savedPhoto = photoRepository.save(photo)

        val fileDownloadUri = ServletUriComponentsBuilder.fromCurrentContextPath()
                .path("/${VERSION}/photo/")
                .path(fileName)
                .toUriString()

        return savedPhoto.response()
    }

    @GetMapping("${VERSION}/photo/{fileName:.+}")
    fun downloadPhoto(@PathVariable fileName: String, request: HttpServletRequest): ResponseEntity<Resource> {
        val resource = fileStorageService.loadFileAsResource(fileName)

        var contentType: String? = null
        try {
            contentType = request.servletContext.getMimeType(resource.file.absolutePath)
        } catch (ex: IOException) {
            logger.info("Could not determine file type.")
        }

        if (contentType == null) {
            contentType = "application/octet-stream"
        }

        return ResponseEntity.ok()
                .contentType(MediaType.parseMediaType(contentType))
                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + resource.filename + "\"")
                .body<Resource>(resource)
    }
}