package com.uav_recon.app.api.controllers

import com.uav_recon.app.api.beans.resources.Resources
import com.uav_recon.app.api.controllers.handlers.FileStorageException
import com.uav_recon.app.api.entities.db.Report
import com.uav_recon.app.api.entities.responses.Response
import com.uav_recon.app.api.repositories.InspectionRepository
import com.uav_recon.app.api.repositories.ReportRepository
import com.uav_recon.app.api.services.FileStorageService
import com.uav_recon.app.api.utils.getFileContentType
import com.uav_recon.app.api.utils.response
import com.uav_recon.app.configurations.ControllerConfiguration.VERSION
import org.springframework.core.io.Resource
import org.springframework.data.repository.findByIdOrNull
import org.springframework.http.HttpHeaders
import org.springframework.http.MediaType
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*
import java.util.*
import javax.servlet.http.HttpServletRequest

@RestController
class ReportController(
        private val reportRepository: ReportRepository,
        private val inspectionRepository: InspectionRepository,
        private val fileStorageService: FileStorageService) {

    @GetMapping("$VERSION/report")
    fun getReport(@RequestParam id: Int, request: HttpServletRequest): ResponseEntity<Resource> {
        val report = reportRepository.findByIdOrNull(id)
        if (report?.file == null) {
            throw FileStorageException("Report not found.")
        }
        val resource = fileStorageService.loadFileAsResource(report.file!!)
        val contentType = resource.getFileContentType(request)

        return ResponseEntity.ok()
                .contentType(MediaType.parseMediaType(contentType))
                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + resource.filename + "\"")
                .body<Resource>(resource)
    }

    @PostMapping("$VERSION/generateReport")
    fun generateReport(@RequestParam inspectionId: Int): Response<Report> {
        val inspection = inspectionRepository.findByIdOrNull(inspectionId)
        val report = Report()
        report.date = Date()
        report.inspection = inspection
        val savedReport = reportRepository.save(report)
        return savedReport.response()
    }
}