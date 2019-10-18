package com.uav_recon.app.api.controllers

import com.uav_recon.app.api.entities.db.Inspection
import com.uav_recon.app.api.services.FileStorageService
import com.uav_recon.app.configurations.ControllerConfiguration.VERSION
import org.springframework.core.io.Resource
import org.springframework.http.HttpHeaders
import org.springframework.http.MediaType
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*

/*@RestController
class ReportGeneratorController(
        private val reportGeneratorService: ReportGeneratorService,
        private val reportService: ReportService,
        private val fileStorageService: FileStorageService) {

    @PostMapping("${VERSION}/report")
    fun report(@RequestBody inspection: Inspection): ResponseEntity<Resource> {
        val fileName = reportService.generateReport(inspection)
        val resource = fileStorageService.loadFileAsResource(fileName)
        return ResponseEntity.ok()
                .contentType(MediaType.parseMediaType("application/pdf"))
                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + resource.filename + "\"")
                .body<Resource>(resource)
    }
}*/