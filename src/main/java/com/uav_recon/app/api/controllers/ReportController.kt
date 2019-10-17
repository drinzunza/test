package com.uav_recon.app.api.controllers

import com.uav_recon.app.api.beans.resources.Resources
import com.uav_recon.app.api.entities.responses.Response
import com.uav_recon.app.api.services.FileStorageService
import com.uav_recon.app.configurations.ControllerConfiguration.VERSION
import org.springframework.core.io.Resource
import org.springframework.http.HttpHeaders
import org.springframework.http.MediaType
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RestController

@RestController
class ReportController(
        private val resources: Resources,
        private val fileStorageService: FileStorageService) {

    @GetMapping("$VERSION/report")
    fun getReport(@RequestBody reportId: Int): ResponseEntity<Resource> {
        val resource = fileStorageService.loadFileAsResource(resources.mockImagePath)
        return ResponseEntity.ok()
                .contentType(MediaType.parseMediaType("application/pdf"))
                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + resources.mockImageName + "\"")
                .body<Resource>(resource)
    }

    @PostMapping("$VERSION/report")
    fun generateReport(): Response<Any> {
        return Response()
    }
}