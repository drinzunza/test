package com.uav_recon.app.api.controllers

import com.uav_recon.app.api.entities.requests.bridge.*
import com.uav_recon.app.api.services.ObservationService
import com.uav_recon.app.configurations.ControllerConfiguration.VERSION
import com.uav_recon.app.configurations.ControllerConfiguration.X_TOKEN
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*

@RestController
class ObservationController(private val observationService: ObservationService) : BaseController() {

    @PostMapping("${VERSION}/inspection/{inspectionUuid}/observation")
    fun createOrUpdate(@RequestHeader(X_TOKEN) token: String,
                       @RequestBody observation: ObservationDto,
                       @PathVariable inspectionUuid: String
    ) : ResponseEntity<ObservationDto> {
        return ResponseEntity.ok(observationService.save(observation, inspectionUuid, getAuthenticatedUserId()))
    }

    @DeleteMapping("${VERSION}/inspection/{inspectionUuid}/observation/{uuid}")
    fun delete(@RequestHeader(X_TOKEN) token: String,
               @PathVariable uuid: String,
               @PathVariable inspectionUuid: String
    ): ResponseEntity<*> {
        observationService.delete(uuid, inspectionUuid)
        return ResponseEntity.ok(success)
    }

    @PostMapping("${VERSION}/inspection/{inspectionUuid}/observation/inspect")
    fun updateInspected(@RequestHeader(X_TOKEN) token: String,
                        @RequestBody body: ObservationInspectDto,
                        @PathVariable inspectionUuid: String
    ) : ResponseEntity<ObservationDto> {
        return ResponseEntity.ok(observationService.updateInspected(body, inspectionUuid, getAuthenticatedUserId()))
    }

    @PatchMapping("${VERSION}/observation/{uuid}")
    fun update(@RequestHeader(X_TOKEN) token: String,
               @PathVariable uuid: String,
               @RequestBody body: ObservationUpdateDto
    ): ResponseEntity<ObservationDto> {
        return ResponseEntity.ok(observationService.updateObservation(getAuthenticatedUser(), uuid, body))
    }
}
