package com.uav_recon.app.api.controllers

import com.uav_recon.app.api.entities.db.templates.SubcomponentAndStructure
import com.uav_recon.app.api.entities.db.templates.SubcomponentInspection
import com.uav_recon.app.api.entities.requests.bridge.templates.SubcomponentAndStructuresDto
import com.uav_recon.app.api.entities.requests.bridge.templates.SubcomponentInspectionDto
import com.uav_recon.app.api.repositories.templates.SubcomponentAndStructureRepository
import com.uav_recon.app.api.repositories.templates.SubcomponentInspectionRepository
import com.uav_recon.app.api.services.TemplateService
import com.uav_recon.app.configurations.ControllerConfiguration.VERSION
import com.uav_recon.app.configurations.ControllerConfiguration.X_TOKEN
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*

@RestController
@RequestMapping("$VERSION/templates")
class TemplateController(
        private val templateService: TemplateService,
        private val subcomponentAndStructureRepository: SubcomponentAndStructureRepository,
        private val subcomponentInspectionRepository: SubcomponentInspectionRepository
) : BaseController() {

    @GetMapping("subcomponent-and-structures")
    fun getSubcomponentAndStructures(
            @RequestHeader(X_TOKEN) token: String,
            @RequestParam structureId: String
    ): ResponseEntity<List<SubcomponentAndStructure>> {
        return ResponseEntity.ok(templateService.getSubcomponentAndStructures(getAuthenticatedUser(), structureId))
    }

    @PostMapping("subcomponent-and-structures")
    fun saveSubcomponentAndStructures(
            @RequestHeader(X_TOKEN) token: String, @RequestBody body: SubcomponentAndStructuresDto
    ): ResponseEntity<List<SubcomponentAndStructure>> {
        val structureIds = body.subcomponentAndStructures.map { it.structureId }
        templateService.saveSubcomponentAndStructures(getAuthenticatedUser(), body)
        return ResponseEntity.ok(subcomponentAndStructureRepository.findAllByStructureIdIn(structureIds))
    }

    @GetMapping("subcomponent-inspections")
    fun getSubcomponentInspection(
            @RequestHeader(X_TOKEN) token: String,
            @RequestParam inspectionId: String
    ): ResponseEntity<List<SubcomponentInspection>> {
        return ResponseEntity.ok(templateService.getSubcomponentInspection(getAuthenticatedUser(), inspectionId))
    }

    @PostMapping("subcomponent-inspections")
    fun saveSubcomponentInspection(
            @RequestHeader(X_TOKEN) token: String, @RequestBody body: SubcomponentInspectionDto
    ): ResponseEntity<List<SubcomponentInspection>> {
        val inspectionIds = body.subcomponentInspections.map { it.inspectionId }
        templateService.saveSubcomponentInspection(getAuthenticatedUser(), body)
        return ResponseEntity.ok(subcomponentInspectionRepository.findAllByInspectionIdIn(inspectionIds))
    }
}