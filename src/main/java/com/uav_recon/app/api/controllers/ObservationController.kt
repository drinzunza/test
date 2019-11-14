package com.uav_recon.app.api.controllers

import com.uav_recon.app.api.entities.requests.bridge.ObservationDto
import com.uav_recon.app.api.services.ObservationService
import com.uav_recon.app.configurations.ControllerConfiguration.VERSION
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.DeleteMapping
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping("${VERSION}/inspection/{inspectionUuid}/observation")
class ObservationController(private val observationService: ObservationService) : BaseController() {

    @PostMapping
    fun createOrUpdate(@RequestBody observation: ObservationDto, @PathVariable inspectionUuid: String):
            ResponseEntity<ObservationDto> {
        return ResponseEntity.ok(observationService.save(observation, inspectionUuid, getAuthenticatedUserId()));
    }

    @DeleteMapping("/{uuid}")
    fun delete(@PathVariable uuid: String, @PathVariable inspectionUuid: String): ResponseEntity<*> {
        observationService.delete(uuid, inspectionUuid)
        return ResponseEntity.ok(success);
    }

}
