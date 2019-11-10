package com.uav_recon.app.api.controllers

import com.uav_recon.app.api.controllers.handlers.FileStorageException
import com.uav_recon.app.api.entities.db.Photo
import com.uav_recon.app.api.repositories.ObservationDefectRepository
import com.uav_recon.app.api.repositories.PhotoRepository
import com.uav_recon.app.api.services.FileStorageService
import com.uav_recon.app.api.utils.getFileContentType
import com.uav_recon.app.configurations.ControllerConfiguration.VERSION
import org.slf4j.LoggerFactory
import org.springframework.core.io.Resource
import org.springframework.data.repository.findByIdOrNull
import org.springframework.http.HttpHeaders
import org.springframework.http.MediaType
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestParam
import org.springframework.web.bind.annotation.RestController
import org.springframework.web.multipart.MultipartFile
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
            @RequestParam("observationDefectId") observationDefectId: String,
            @RequestParam("file") file: MultipartFile
    ): ResponseEntity<*> {
        val now = Date()
        val extension = file.originalFilename?.substringAfterLast('.', "")
        val uniqueFileName = "photo_${now.time}.$extension"
        if (fileStorageService.getFile(uniqueFileName).exists()) {
            throw FileStorageException("Photo already exists.")
        }

        val fileName = fileStorageService.storeFile(file, uniqueFileName)
        val observationDefect = observationDefectRepository.findByIdOrNull(observationDefectId)

        val photo = Photo("", "", 0, 0, "", "")
        val savedPhoto = photoRepository.save(photo)
        return ResponseEntity.ok("")
    }

    @GetMapping("${VERSION}/photo")
    fun downloadPhoto(@RequestParam id: String, request: HttpServletRequest): ResponseEntity<Resource> {
        val photo = photoRepository.findByIdOrNull(id)
        if (photo?.link == null) {
            throw FileStorageException("Photo not found.")
        }
        val resource = fileStorageService.loadFileAsResource(photo.link!!)
        val contentType = resource.getFileContentType(request)
        return ResponseEntity.ok()
                .contentType(MediaType.parseMediaType(contentType))
                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + resource.filename + "\"")
                .body<Resource>(resource)
    }
}
