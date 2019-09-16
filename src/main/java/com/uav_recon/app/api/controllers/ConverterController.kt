package com.uav_recon.app.api.controllers

import com.uav_recon.app.api.entities.responses.UploadFileResponse
import com.uav_recon.app.api.services.FileStorageService
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
import java.util.stream.Collectors
import javax.servlet.http.HttpServletRequest

@RestController
class ConverterController(private val fileStorageService: FileStorageService) {

    private val logger = LoggerFactory.getLogger(ConverterController::class.java)

    @PostMapping("${VERSION}/uploadFile")
    fun uploadFile(@RequestParam("file") file: MultipartFile): UploadFileResponse {
        val fileName = fileStorageService.storeFile(file)

        val fileDownloadUri = ServletUriComponentsBuilder.fromCurrentContextPath()
                .path("/${VERSION}/downloadFile/")
                .path(fileName)
                .toUriString()

        return UploadFileResponse(fileName, fileDownloadUri, file.contentType!!, file.size)
    }

    @PostMapping("${VERSION}/uploadMultipleFiles")
    fun uploadMultipleFiles(@RequestParam("files") files: List<MultipartFile>): List<UploadFileResponse> {
        return files
                .stream()
                .map { file -> uploadFile(file) }
                .collect(Collectors.toList())
    }

    @GetMapping("${VERSION}/downloadFile/{fileName:.+}")
    fun downloadFile(@PathVariable fileName: String, request: HttpServletRequest): ResponseEntity<Resource> {
        // Load file as Resource
        val resource = fileStorageService.loadFileAsResource(fileName)

        // Try to determine file's content type
        var contentType: String? = null
        try {
            contentType = request.servletContext.getMimeType(resource.file.absolutePath)
        } catch (ex: IOException) {
            logger.info("Could not determine file type.")
        }

        // Fallback to the default content type if type could not be determined
        if (contentType == null) {
            contentType = "application/octet-stream"
        }

        return ResponseEntity.ok()
                .contentType(MediaType.parseMediaType(contentType))
                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + resource.filename + "\"")
                .body<Resource>(resource)
    }
}