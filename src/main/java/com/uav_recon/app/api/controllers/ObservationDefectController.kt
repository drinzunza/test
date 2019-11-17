package com.uav_recon.app.api.controllers

import com.uav_recon.app.api.entities.requests.bridge.ObservationDefectDto
import com.uav_recon.app.api.services.ObservationDefectService
import com.uav_recon.app.configurations.ControllerConfiguration.VERSION
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.DeleteMapping
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping("${VERSION}/inspection/{inspectionId}/observation/{observationId}/observationDefect")
class ObservationDefectController(private val observationDefectService: ObservationDefectService) : BaseController() {

    @PostMapping
    fun createOrUpdate(@RequestBody observationDefectDto: ObservationDefectDto, @PathVariable inspectionId: String,
                       @PathVariable observationId: String): ResponseEntity<ObservationDefectDto> {
        return ResponseEntity.ok(observationDefectService.save(observationDefectDto, inspectionId, observationId,
                                                               getAuthenticatedUserId()))
    }

    @DeleteMapping("/{defectId}")
    fun delete(@PathVariable defectId: String, @PathVariable inspectionId: String, @PathVariable observationId:
    String): ResponseEntity<*> {
        observationDefectService.delete(defectId, inspectionId, observationId)
        return ResponseEntity.ok(success)
    }


}
