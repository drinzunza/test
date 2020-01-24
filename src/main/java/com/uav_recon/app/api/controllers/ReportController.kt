package com.uav_recon.app.api.controllers

import com.uav_recon.app.api.entities.requests.bridge.ReportDto
import com.uav_recon.app.api.services.report.ReportService
import com.uav_recon.app.configurations.ControllerConfiguration.VERSION
import com.uav_recon.app.configurations.ControllerConfiguration.X_TOKEN
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*

@RestController
class ReportController(private val reportService: ReportService) : BaseController() {

    @GetMapping("$VERSION/inspection/{inspectionId}/report")
    fun get(@RequestHeader(X_TOKEN) token: String, @PathVariable inspectionId: String): ResponseEntity<ReportDto>  {
        return ResponseEntity.ok(reportService.getLastReportDto(inspectionId))
    }

    @PostMapping("$VERSION/inspection/{inspectionId}/report")
    fun generate(@RequestHeader(X_TOKEN) token: String, @PathVariable inspectionId: String): ResponseEntity<ReportDto>  {
        return ResponseEntity.ok(reportService.generate(getAuthenticatedUserId(), inspectionId))
    }
}
