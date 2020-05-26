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

    @GetMapping("/subcomponents/structure/{structureId}")
    fun getSubcomponentsHealthByStructure(@RequestHeader(X_TOKEN) token: String,
                                          @PathVariable structureId: String?
    ): ResponseEntity<List<SubcomponentHealthDto>> {
        val inspections = inspectionService.listNotDeleted(getAuthenticatedUser(), null, structureId, null)
        return ResponseEntity.ok(mainDocumentFactory.createObservationSummary(inspections))
    }

    @GetMapping("/subcomponents/company/{companyId}")
    fun getSubcomponentsHealthByCompany(@RequestHeader(X_TOKEN) token: String,
                                        @PathVariable companyId: Long?
    ): ResponseEntity<List<SubcomponentHealthDto>> {
        val inspections = inspectionService.listNotDeleted(getAuthenticatedUser(), null, null, companyId)
        return ResponseEntity.ok(mainDocumentFactory.createObservationSummary(inspections))
    }

    @GetMapping("/defects/company/{companyId}")
    fun getObservationDefectsByCompany(@RequestHeader(X_TOKEN) token: String,
                                       @PathVariable companyId: Long,
                                       @RequestParam(required = false) inspectionId: String?
    ): ResponseEntity<List<ObservationDefectReportDto>> {
        val inspections = inspectionService.listNotDeleted(getAuthenticatedUser(), null, null, companyId)
                .filter { !(inspectionId != null && it.uuid != inspectionId) }
        return ResponseEntity.ok(mainDocumentFactory.createObservationDefectSummary(inspections))
    }

    @GetMapping("/defects/structure/{structureId}")
    fun getObservationDefectsByStructure(@RequestHeader(X_TOKEN) token: String,
                                         @PathVariable structureId: String,
                                         @RequestParam(required = false) inspectionId: String?
    ): ResponseEntity<List<ObservationDefectReportDto>> {
        val inspections = inspectionService.listNotDeleted(getAuthenticatedUser(), null, structureId, null)
                .filter { !(inspectionId != null && it.uuid != inspectionId) }
        return ResponseEntity.ok(mainDocumentFactory.createObservationDefectSummary(inspections))
    }
}
