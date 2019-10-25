package com.uav_recon.app.api.controllers

import com.uav_recon.app.api.entities.db.Inspection
import com.uav_recon.app.api.entities.requests.bridge.InspectionRequest
import com.uav_recon.app.api.entities.responses.Response
import com.uav_recon.app.api.entities.responses.bridge.InspectionResponse
import com.uav_recon.app.api.repositories.CompanyRepository
import com.uav_recon.app.api.repositories.InspectionRepository
import com.uav_recon.app.api.repositories.InspectorRepository
import com.uav_recon.app.api.repositories.StructureRepository
import com.uav_recon.app.api.utils.response
import com.uav_recon.app.api.utils.toResponse
import com.uav_recon.app.configurations.ControllerConfiguration.VERSION
import org.springframework.data.repository.findByIdOrNull
import org.springframework.web.bind.annotation.*

@RestController
class InspectionController(
        private val inspectionRepository: InspectionRepository,
        private val companyRepository: CompanyRepository,
        private val structureRepository: StructureRepository,
        private val inspectorRepository: InspectorRepository) {

    @GetMapping("$VERSION/inspection")
    fun getInspection(@RequestParam inspectionId: Int): Response<InspectionResponse> {
        val inspection = inspectionRepository.findByIdOrNull(inspectionId)
        return inspection?.toResponse()?.response() ?: Response()
    }

    @PostMapping("$VERSION/inspection")
    fun setInspection(@RequestBody inspection: InspectionRequest): Response<InspectionResponse> {
        val result = Inspection()
        result.startDate = inspection.startDate
        result.endDate = inspection.endDate
        result.endDate = inspection.endDate
        result.structure = inspection.structureId?.let { structureRepository.findByIdOrNull(it) }
        result.status = inspection.status
        result.company = inspection.companyId?.let { companyRepository.findByIdOrNull(it) }
        result.inspector = inspection.inspectorId?.let { inspectorRepository.findByIdOrNull(it) }
        result.generalSummary = inspection.generalSummary
        result.termRating = inspection.termRating
        result.sgrRating = inspection.sgrRating
        result.temperature = inspection.temperature
        result.humidity = inspection.humidity
        result.wind = inspection.wind

        val savedInspection = inspectionRepository.save(result)
        return savedInspection.toResponse().response()
    }
}