package com.uav_recon.app.api.controllers

import com.uav_recon.app.api.entities.requests.bridge.ObservationDto
import com.uav_recon.app.api.services.ObservationService
import com.uav_recon.app.configurations.ControllerConfiguration
import com.uav_recon.app.configurations.ControllerConfiguration.VERSION
import com.uav_recon.app.configurations.ControllerConfiguration.X_TOKEN
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*

@RestController
@RequestMapping("${VERSION}/inspection/{inspectionUuid}/observation")
class ObservationController(private val observationService: ObservationService) : BaseController() {

    @PostMapping
    fun createOrUpdate(@RequestHeader(X_TOKEN) token: String, @RequestBody observation: ObservationDto, @PathVariable inspectionUuid: String):
            ResponseEntity<ObservationDto> {
        return ResponseEntity.ok(observationService.save(observation, inspectionUuid, getAuthenticatedUserId()));
    }

    @DeleteMapping("/{uuid}")
    fun delete(@RequestHeader(X_TOKEN) token: String, @PathVariable uuid: String, @PathVariable inspectionUuid: String): ResponseEntity<*> {
        observationService.delete(uuid, inspectionUuid)
        return ResponseEntity.ok(success);
    }
}
