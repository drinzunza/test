package com.uav_recon.app.api.controllers

import com.uav_recon.app.api.entities.db.Observation
import com.uav_recon.app.api.entities.requests.bridge.ObservationRequest
import com.uav_recon.app.api.entities.responses.Response
import com.uav_recon.app.api.entities.responses.bridge.ObservationResponse
import com.uav_recon.app.api.repositories.InspectionRepository
import com.uav_recon.app.api.repositories.ObservationRepository
import com.uav_recon.app.api.repositories.StructuralComponentRepository
import com.uav_recon.app.api.repositories.SubcomponentRepository
import com.uav_recon.app.api.utils.response
import com.uav_recon.app.api.utils.toResponse
import com.uav_recon.app.configurations.ControllerConfiguration.VERSION
import org.springframework.data.repository.findByIdOrNull
import org.springframework.web.bind.annotation.*

@RestController
class ObservationController(
        private val observationRepository: ObservationRepository,
        private val inspectionRepository: InspectionRepository,
        private val structuralComponentRepository: StructuralComponentRepository,
        private val subcomponentRepository: SubcomponentRepository
) {

    @GetMapping("$VERSION/observation")
    fun getObservation(@RequestParam observationId: Int): Response<ObservationResponse> {
        val observation = observationRepository.findByIdOrNull(observationId)
        return observation?.toResponse()?.response() ?: Response()
    }

    @PostMapping("$VERSION/observation")
    fun setObservation(@RequestBody observation: ObservationRequest): Response<ObservationResponse> {
        val result = Observation()
        result.code = observation.code
        result.inspection = observation.inspectionId?.let { inspectionRepository.findByIdOrNull(it) }
        result.drawingNumber = observation.drawingNumber
        result.roomNumber = observation.roomNumber
        result.spanNumber = observation.spanNumber
        result.locationDescription = observation.locationDescription
        result.structuralComponent = observation.structuralComponentId?.let { structuralComponentRepository.findByIdOrNull(it) }
        result.subcomponent = observation.subcomponentId?.let { subcomponentRepository.findByIdOrNull(it) }

        val savedObservation = observationRepository.save(result)
        return savedObservation.toResponse().response()
    }
}