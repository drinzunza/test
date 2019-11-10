package com.uav_recon.app.api.controllers

import com.uav_recon.app.api.entities.requests.bridge.InspectionDto
import com.uav_recon.app.api.services.InspectionService
import com.uav_recon.app.configurations.ControllerConfiguration.VERSION
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*
import java.util.*

@RestController
@RequestMapping("$VERSION/inspection")
class InspectionController(private val inspectionService: InspectionService) {

    private val success = Collections.singletonMap("success", true)

    @GetMapping
    fun get(): ResponseEntity<List<InspectionDto>> {
        return ResponseEntity.ok(inspectionService.list())
    }

    @PostMapping
    fun createOrUpdate(@RequestBody body: InspectionDto): ResponseEntity<InspectionDto> {
        return ResponseEntity.ok(inspectionService.save(body, 1))
    }

    @DeleteMapping("/{uuid}")
    fun delete(@PathVariable uuid: String): ResponseEntity<*> {
        inspectionService.delete(uuid)
        return ResponseEntity.ok(success)
    }

    @PostMapping("/full")
    fun full(@RequestBody body: InspectionDto): ResponseEntity<*> {
        return ResponseEntity.ok(inspectionService.save(body, 1))
    }
}
