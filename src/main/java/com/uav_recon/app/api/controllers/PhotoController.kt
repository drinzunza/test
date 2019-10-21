package com.uav_recon.app.api.controllers

import com.uav_recon.app.api.entities.db.Photo
import com.uav_recon.app.api.entities.requests.photo.PhotoRequest
import com.uav_recon.app.api.entities.responses.Response
import com.uav_recon.app.api.entities.responses.UploadFileResponse
import com.uav_recon.app.api.entities.responses.photo.PhotoResponse
import com.uav_recon.app.api.repositories.PhotoRepository
import com.uav_recon.app.api.services.FileStorageService
import com.uav_recon.app.api.utils.response
import com.uav_recon.app.configurations.ControllerConfiguration.VERSION
import org.slf4j.LoggerFactory
import org.springframework.core.io.Resource
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
        private val photoRepository: PhotoRepository
) {

    private val logger = LoggerFactory.getLogger(PhotoController::class.java)

    @PostMapping("${VERSION}/photo")
    fun uploadPhoto(
            @RequestPart("photoRequest") photoRequest: PhotoRequest,
            @RequestPart("file") file: MultipartFile
    ): Response<PhotoResponse> {
        val fileName = fileStorageService.storeFile(file)

        val photo = Photo()
        photo.file = fileName
        photo.latitude = photoRequest.latitude
        photo.longitude = photoRequest.longitude
        photo.altitude = photoRequest.altitude
        photo.startX = photoRequest.startX
        photo.startY = photoRequest.startY
        photo.endX = photoRequest.endX
        photo.endY = photoRequest.endY
        photo.createdDate = Date()

        val savedPhoto = photoRepository.save(photo)
        val response = PhotoResponse(
                savedPhoto.id,
                savedPhoto.latitude,
                savedPhoto.longitude,
                savedPhoto.altitude,
                savedPhoto.startX,
                savedPhoto.startY,
                savedPhoto.endX,
                savedPhoto.endY,
                savedPhoto.createdDate
        )

        val fileDownloadUri = ServletUriComponentsBuilder.fromCurrentContextPath()
                .path("/${VERSION}/photo/")
                .path(fileName)
                .toUriString()

        return response.response()
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