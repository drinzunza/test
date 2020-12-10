package com.uav_recon.app.api.controllers

import com.uav_recon.app.api.entities.requests.bridge.ObservationDefectDto
import com.uav_recon.app.api.services.ObservationDefectService
import com.uav_recon.app.configurations.ControllerConfiguration
import com.uav_recon.app.configurations.ControllerConfiguration.VERSION
import com.uav_recon.app.configurations.ControllerConfiguration.X_TOKEN
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*

@RestController
class ObservationDefectController(private val observationDefectService: ObservationDefectService) : BaseController() {

    @PostMapping("${VERSION}/inspection/{inspectionId}/observation/{observationId}/observationDefect")
    fun createOrUpdate(@RequestHeader(X_TOKEN) token: String,
                       @RequestBody observationDefectDto: ObservationDefectDto,
                       @PathVariable inspectionId: String,
                       @PathVariable observationId: String
    ): ResponseEntity<ObservationDefectDto> {
        return ResponseEntity.ok(observationDefectService.save(
                observationDefectDto, inspectionId, observationId, getAuthenticatedUserId()
        ))
    }

    @DeleteMapping("${VERSION}/inspection/{inspectionId}/observation/{observationId}/observationDefect/{defectId}")
    fun delete(@RequestHeader(X_TOKEN) token: String,
               @PathVariable defectId: String,
               @PathVariable inspectionId: String,
               @PathVariable observationId: String
    ): ResponseEntity<*> {
        observationDefectService.delete(defectId, inspectionId, observationId)
        return ResponseEntity.ok(success)
    }

    @PutMapping("${VERSION}/observation-defect/{defectId}/new-observation/{observationId}")
    fun updateObservation(@RequestHeader(X_TOKEN) token: String,
                          @PathVariable defectId: String,
                          @PathVariable observationId: String
    ): ResponseEntity<ObservationDefectDto> {
        return ResponseEntity.ok(observationDefectService.update(getAuthenticatedUserId(), defectId, observationId))
    }
}
