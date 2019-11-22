package com.uav_recon.app.api.controllers

import com.uav_recon.app.api.controllers.handlers.FileStorageException
import com.uav_recon.app.api.entities.db.Report
import com.uav_recon.app.api.entities.responses.Response
import com.uav_recon.app.api.entities.responses.bridge.ReportResponse
import com.uav_recon.app.api.repositories.InspectionRepository
import com.uav_recon.app.api.repositories.ReportRepository
import com.uav_recon.app.api.services.FileStorageService
import com.uav_recon.app.api.services.report.DocumentWriter
import com.uav_recon.app.api.services.report.document.DocumentFactory
import com.uav_recon.app.api.utils.getFileContentType
import com.uav_recon.app.api.utils.response
import com.uav_recon.app.api.utils.toResponse
import com.uav_recon.app.configurations.ControllerConfiguration
import com.uav_recon.app.configurations.ControllerConfiguration.VERSION
import com.uav_recon.app.configurations.ControllerConfiguration.X_TOKEN
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
        private val documentWriter: DocumentWriter,
        private val documentFactory: DocumentFactory,
        private val fileStorageService: FileStorageService) {

    @GetMapping("$VERSION/report")
    fun getReport(@RequestHeader(X_TOKEN) token: String, @RequestParam id: Int, request: HttpServletRequest): ResponseEntity<Resource> {
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

    @PostMapping("$VERSION/report")
    fun generateReport(@RequestHeader(X_TOKEN) token: String, @RequestParam inspectionId: String): Response<ReportResponse> {
        val inspection = inspectionRepository.findByIdOrNull(inspectionId)
                ?: throw FileStorageException("Inspection does not exists.")

        val now = Date()
        val uniqueFileName = "report_${now.time}.docx"
        if (fileStorageService.getFile(uniqueFileName).exists()) {
            throw FileStorageException("Report already exists.")
        }

        val report = Report()
        report.date = Date()
        report.file = uniqueFileName
        report.inspection = inspection

        val document = documentFactory.generateDocument(report)
        documentWriter.writeDocument(document, fileStorageService.getFile(uniqueFileName))
        val savedReport = reportRepository.save(report)

        return savedReport.toResponse().response()
    }
}
