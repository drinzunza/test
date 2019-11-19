package com.uav_recon.app.api.controllers

import com.uav_recon.app.api.entities.requests.bridge.InspectionDto
import com.uav_recon.app.api.services.InspectionService
import com.uav_recon.app.configurations.ControllerConfiguration.VERSION
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.DeleteMapping
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping("$VERSION/inspection")
class InspectionController(private val inspectionService: InspectionService) : BaseController() {

    @GetMapping
    fun get(): ResponseEntity<List<InspectionDto>> {
        return ResponseEntity.ok(inspectionService.listNotDeleted(getAuthenticatedUserId()))
    }

    @PostMapping
    fun createOrUpdate(@RequestBody body: InspectionDto): ResponseEntity<InspectionDto> {
        return ResponseEntity.ok(inspectionService.save(body, getAuthenticatedUserId()))
    }

    @DeleteMapping("/{uuid}")
    fun delete(@PathVariable uuid: String): ResponseEntity<*> {
        inspectionService.delete(uuid)
        return ResponseEntity.ok(success)
    }

    @PostMapping("/full")
    fun full(@RequestBody body: InspectionDto): ResponseEntity<*> {
        return ResponseEntity.ok(inspectionService.save(body, getAuthenticatedUserId()))
    }
}
