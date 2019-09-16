package com.uav_recon.app.api.controllers

import com.uav_recon.app.api.entities.Inspection
import com.uav_recon.app.api.services.FileStorageService
import com.uav_recon.app.api.services.ReportGeneratorService
import com.uav_recon.app.configurations.ControllerConfiguration.VERSION
import org.springframework.core.io.Resource
import org.springframework.http.HttpHeaders
import org.springframework.http.MediaType
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*
import javax.servlet.http.HttpServletRequest

@RestController
class ReportGeneratorController(
        private val reportGeneratorService: ReportGeneratorService,
        private val fileStorageService: FileStorageService) {

    @PostMapping("${VERSION}/report")
    fun report(@RequestBody inspection: Inspection, request: HttpServletRequest): ResponseEntity<Resource> {
        val fileName = reportGeneratorService.generateReport(inspection)
        val resource = fileStorageService.loadFileAsResource(fileName)
        val contentType = "application/pdf"
        return ResponseEntity.ok()
                .contentType(MediaType.parseMediaType(contentType))
                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + resource.filename + "\"")
                .body<Resource>(resource)
    }
}