package com.uav_recon.app.api.controllers

import com.uav_recon.app.api.controllers.handlers.FileStorageException
import com.uav_recon.app.api.entities.db.Photo
import com.uav_recon.app.api.entities.responses.Response
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
    ): Response<PhotoResponse> {
        val now = Date()
        val extension = file.originalFilename?.substringAfterLast('.', "")
        val uniqueFileName = "photo_${now.time}.$extension"
        if (fileStorageService.getFile(uniqueFileName).exists()) {
            throw FileStorageException("Photo already exists.")
        }

        val fileName = fileStorageService.storeFile(file, uniqueFileName)
        val observationDefect = observationDefectRepository.findByIdOrNull(observationDefectId)

        val photo = Photo(0, fileName, latitude, longitude, altitude, startX, startY, endX, endY, now, observationDefect)
        val savedPhoto = photoRepository.save(photo)
        val response = savedPhoto.run {
            PhotoResponse(this.id, this.file, this.latitude, this.longitude, this.altitude,
                    this.startX, this.startY, this.endX, this.endY, this.createdDate, this.observationDefect?.id)
        }

        return response.response()
    }

//    @GetMapping("${VERSION}/photo/{fileName:.+}")
//    fun downloadPhoto(@PathVariable fileName: String, request: HttpServletRequest): ResponseEntity<Resource> {
//        val resource = fileStorageService.loadFileAsResource(fileName)
//        val contentType = getFileContentType(request, resource)
//        return ResponseEntity.ok()
//                .contentType(MediaType.parseMediaType(contentType))
//                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + resource.filename + "\"")
//                .body<Resource>(resource)
//    }

    @GetMapping("${VERSION}/photo/{id}")
    fun downloadPhoto(@PathVariable id: Int, request: HttpServletRequest): ResponseEntity<Resource> {
        val photo = photoRepository.findByIdOrNull(id)
        if (photo?.file == null) {
            throw FileStorageException("Photo not found.")
        }
        val resource = fileStorageService.loadFileAsResource(photo.file!!)
        val contentType = getFileContentType(request, resource)
        return ResponseEntity.ok()
                .contentType(MediaType.parseMediaType(contentType))
                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + resource.filename + "\"")
                .body<Resource>(resource)
    }

    private fun getFileContentType(request: HttpServletRequest, resource: Resource): String {
        var contentType: String? = null
        try {
            contentType = request.servletContext.getMimeType(resource.file.absolutePath)
        } catch (ex: IOException) {
            logger.info("Could not determine file type.")
        }

        if (contentType == null) {
            contentType = "application/octet-stream"
        }
        return contentType
    }
}