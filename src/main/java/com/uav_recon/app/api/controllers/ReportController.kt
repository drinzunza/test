package com.uav_recon.app.api.controllers

import com.uav_recon.app.api.entities.requests.bridge.ReportDto
import com.uav_recon.app.api.entities.responses.bridge.ObservationDefectReportDto
import com.uav_recon.app.api.entities.responses.bridge.SubcomponentHealthDto
import com.uav_recon.app.api.services.InspectionService
import com.uav_recon.app.api.services.report.ReportService
import com.uav_recon.app.api.services.report.document.main.MainDocumentFactory
import com.uav_recon.app.configurations.ControllerConfiguration.VERSION
import com.uav_recon.app.configurations.ControllerConfiguration.X_TOKEN
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*

@RestController
@RequestMapping("${VERSION}/report")
class ReportController(
        private val reportService: ReportService,
        private val inspectionService: InspectionService,
        private val mainDocumentFactory: MainDocumentFactory
) : BaseController() {

    @GetMapping("/inspection/{inspectionId}")
    fun get(@RequestHeader(X_TOKEN) token: String, @RequestParam inspectionId: String): ResponseEntity<ReportDto>  {
        return ResponseEntity.ok(reportService.getLastReportDto(inspectionId))
    }

    @PostMapping("/inspection/{inspectionId}/report")
    fun generate(@RequestHeader(X_TOKEN) token: String, @PathVariable inspectionId: String): ResponseEntity<ReportDto>  {
        return ResponseEntity.ok(reportService.generate(getAuthenticatedUserId(), inspectionId))
    }

    @GetMapping("/subcomponents")
    fun getSubcomponentsHealth(@RequestHeader(X_TOKEN) token: String,
                               @RequestParam(required = false) structureId: String?
    ): ResponseEntity<List<SubcomponentHealthDto>> {
        val inspections = inspectionService.listNotDeleted(getAuthenticatedUser(), null, structureId)
        return ResponseEntity.ok(mainDocumentFactory.createObservationSummary(inspections))
    }

    @GetMapping("/defects")
    fun getObservationDefects(@RequestHeader(X_TOKEN) token: String,
                              @RequestParam(required = false) structureId: String?,
                              @RequestParam(required = false) inspectionId: String?
    ): ResponseEntity<List<ObservationDefectReportDto>> {
        val inspections = inspectionService.listNotDeleted(getAuthenticatedUser(), null, structureId)
                .filter { !(inspectionId != null && it.uuid != inspectionId) }
        return ResponseEntity.ok(mainDocumentFactory.createObservationDefectSummary(inspections))
    }
}
