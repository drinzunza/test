package com.uav_recon.app.api.controllers

import com.uav_recon.app.api.entities.requests.bridge.InspectionDto
import com.uav_recon.app.api.services.InspectionService
import com.uav_recon.app.configurations.ControllerConfiguration.VERSION
import com.uav_recon.app.configurations.ControllerConfiguration.X_TOKEN
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*

@RestController
@RequestMapping("$VERSION/inspection")
class InspectionController(private val inspectionService: InspectionService) : BaseController() {

    @GetMapping
    fun get(@RequestHeader(X_TOKEN) token: String): ResponseEntity<List<InspectionDto>> {
        return ResponseEntity.ok(inspectionService.listNotDeleted())
    }

    @PostMapping
    fun createOrUpdate(@RequestHeader(X_TOKEN) token: String, @RequestBody body: InspectionDto): ResponseEntity<InspectionDto> {
        return ResponseEntity.ok(inspectionService.save(body, getAuthenticatedUserId()))
    }

    @DeleteMapping("/{uuid}")
    fun delete(@RequestHeader(X_TOKEN) token: String, @PathVariable uuid: String): ResponseEntity<*> {
        inspectionService.delete(uuid)
        return ResponseEntity.ok(success)
    }

    @PostMapping("/full")
    fun full(@RequestHeader(X_TOKEN) token: String, @RequestBody body: InspectionDto): ResponseEntity<*> {
        return ResponseEntity.ok(inspectionService.save(body, getAuthenticatedUserId()))
    }
}
