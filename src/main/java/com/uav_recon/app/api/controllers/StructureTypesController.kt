package com.uav_recon.app.api.controllers

import com.uav_recon.app.api.entities.db.StructureType
import com.uav_recon.app.api.entities.requests.bridge.ProjectDto
import com.uav_recon.app.api.entities.requests.bridge.ProjectIdsDto
import com.uav_recon.app.api.entities.requests.bridge.StructureTypeDto
import com.uav_recon.app.api.entities.requests.bridge.StructureTypeIdsDto
import com.uav_recon.app.api.services.StructureTypesService
import com.uav_recon.app.configurations.ControllerConfiguration.VERSION
import com.uav_recon.app.configurations.ControllerConfiguration.X_TOKEN
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*

@RestController
@RequestMapping("$VERSION/structure-types")
class StructureTypesController(private val structureTypesService: StructureTypesService) : BaseController() {

    @GetMapping
    fun getTypes(@RequestHeader(X_TOKEN) token: String): ResponseEntity<List<StructureTypeDto>> {
        return ResponseEntity.ok(structureTypesService.getTypes(getAuthenticatedUser()))
    }

    @GetMapping("/{typeId}")
    fun getType(@RequestHeader(X_TOKEN) token: String, @PathVariable typeId: String): ResponseEntity<StructureTypeDto> {
        return ResponseEntity.ok(structureTypesService.getType(getAuthenticatedUser(), typeId))
    }

    @PostMapping("/insert")
    fun insertType(@RequestHeader(X_TOKEN) token: String, @RequestBody body: StructureTypeDto): ResponseEntity<StructureTypeDto> {
        return ResponseEntity.ok(structureTypesService.insert(getAuthenticatedUser(), body))
    }

    @PutMapping("/update")
    fun updateType(@RequestHeader(X_TOKEN) token: String, @RequestBody body: StructureTypeDto): ResponseEntity<StructureTypeDto> {
        return ResponseEntity.ok(structureTypesService.update(getAuthenticatedUser(), body))
    }

    @DeleteMapping("/delete/{typeId}")
    fun deleteType(@RequestHeader(X_TOKEN) token: String, @PathVariable typeId: String): ResponseEntity<*> {
        structureTypesService.delete(getAuthenticatedUser(), typeId)
        return ResponseEntity.ok(success)
    }

    @GetMapping("/company/{companyId}")
    fun getCompanyTypes(@RequestHeader(X_TOKEN) token: String, @PathVariable companyId: Long): ResponseEntity<List<StructureTypeDto>> {
        return ResponseEntity.ok(structureTypesService.getCompanyTypes(getAuthenticatedUser(), companyId))
    }

    @PostMapping("/company/{companyId}")
    fun setCompanyTypes(@RequestHeader(X_TOKEN) token: String, @PathVariable companyId: Long, @RequestBody body: StructureTypeIdsDto): ResponseEntity<List<StructureTypeDto>> {
        return ResponseEntity.ok(structureTypesService.setCompanyTypes(getAuthenticatedUser(), companyId, body))
    }
}