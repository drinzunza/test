package com.uav_recon.app.api.controllers

import com.uav_recon.app.api.entities.db.ObservationDefect
import com.uav_recon.app.api.entities.requests.bridge.ObservationDefectRequest
import com.uav_recon.app.api.entities.responses.Response
import com.uav_recon.app.api.entities.responses.bridge.ObservationDefectResponse
import com.uav_recon.app.api.repositories.*
import com.uav_recon.app.api.utils.response
import com.uav_recon.app.api.utils.toResponse
import com.uav_recon.app.configurations.ControllerConfiguration.VERSION
import org.springframework.data.repository.findByIdOrNull
import org.springframework.web.bind.annotation.*

@RestController
class ObservationDefectController(
        private val observationDefectRepository: ObservationDefectRepository,
        private val observationRepository: ObservationRepository,
        private val defectRepository: DefectRepository,
        private val conditionRepository: ConditionRepository,
        private val materialRepository: MaterialRepository
) {

    @GetMapping("$VERSION/observationDefect")
    fun getObservationDefect(@RequestParam observationDefectId: Int): Response<ObservationDefectResponse> {
        val observationDefect = observationDefectRepository.findByIdOrNull(observationDefectId)
        return observationDefect?.toResponse()?.response() ?: Response()
    }

    @PostMapping("$VERSION/observationDefect")
    fun setObservationDefect(@RequestBody observationDefect: ObservationDefectRequest): Response<ObservationDefectResponse> {
        val result = ObservationDefect()
        result.defect = observationDefect.defectId?.let { defectRepository.findByIdOrNull(it) }
        result.condition = observationDefect.conditionId?.let { conditionRepository.findByIdOrNull(it) }
        result.observation = observationDefect.observationId?.let { observationRepository.findByIdOrNull(it) }
        result.description = observationDefect.description
        result.material = observationDefect.materialId?.let { materialRepository.findByIdOrNull(it) }
        result.criticalFindings = observationDefect.criticalFindings
        result.size = observationDefect.size

        val savedObservationDefect = observationDefectRepository.save(result)
        return savedObservationDefect.toResponse().response()
    }
}