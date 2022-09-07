package com.uav_recon.app.api.controllers

import com.uav_recon.app.api.entities.db.StructuralType
import com.uav_recon.app.api.entities.db.StructureType
import com.uav_recon.app.api.entities.db.toDto
import com.uav_recon.app.api.entities.requests.bridge.ReportDto
import com.uav_recon.app.api.entities.requests.bridge.ReportGenerateDto
import com.uav_recon.app.api.entities.responses.bridge.ComponentTypesUsageDto
import com.uav_recon.app.api.entities.responses.bridge.ComponentUsageDto
import com.uav_recon.app.api.entities.responses.bridge.ObservationDefectReportDto
import com.uav_recon.app.api.entities.responses.bridge.SubcomponentHealthDto
import com.uav_recon.app.api.repositories.ComponentRepository
import com.uav_recon.app.api.repositories.ObservationDefectRepository
import com.uav_recon.app.api.repositories.ObservationRepository
import com.uav_recon.app.api.services.InspectionService
import com.uav_recon.app.api.services.ObservationService
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
    fun generate(
        @RequestHeader(X_TOKEN) token: String,
        @PathVariable inspectionId: String,
        @RequestBody body: ReportGenerateDto
    ): ResponseEntity<ReportDto>  {
        return ResponseEntity.ok(reportService.generate(getAuthenticatedUserId(), inspectionId, body))
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

    @GetMapping("/components-usage")
    fun getComponentsUsage(
            @RequestHeader(X_TOKEN) token: String,
            @RequestParam(required = false) structureId: String?,
            @RequestParam(required = false) projectId: Long?,
            @RequestParam(required = false) type: StructuralType?
    ): ResponseEntity<List<ComponentUsageDto>> {
        return ResponseEntity.ok(inspectionService.getComponentUsage(getAuthenticatedUser(), projectId, structureId, type))
    }

    @GetMapping("/component-types-usage")
    fun getComponentTypesUsage(
            @RequestHeader(X_TOKEN) token: String,
            @RequestParam(required = false) structureId: String?,
            @RequestParam(required = false) projectId: Long?
    ): ResponseEntity<ComponentTypesUsageDto> {
        return ResponseEntity.ok(inspectionService.getComponentTypesUsage(getAuthenticatedUser(), projectId, structureId))
    }
}
