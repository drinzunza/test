package com.uav_recon.app.api.controllers

import com.uav_recon.app.api.controllers.dto.admin.AdminStructureInDTO
import com.uav_recon.app.api.controllers.dto.admin.AdminStructureOutDTO
import com.uav_recon.app.api.services.StructureService
import com.uav_recon.app.configurations.ControllerConfiguration.VERSION
import com.uav_recon.app.configurations.ControllerConfiguration.X_TOKEN
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*
import javax.validation.Valid

@RestController
@RequestMapping("${VERSION}/admin/structures")
class AdminStructureController(
        private val structureService: StructureService
) : BaseController() {

    @GetMapping
    fun list(@RequestHeader(X_TOKEN) token: String,
             @RequestParam(required = false) companyId: Long?
    ): ResponseEntity<List<AdminStructureOutDTO>> {
        return ResponseEntity.ok(structureService.listStructures(getAuthenticatedUser(), companyId))
    }

    @PostMapping
    fun create(@RequestHeader(X_TOKEN) token: String,
               @Valid @RequestBody dto: AdminStructureInDTO
    ): ResponseEntity<AdminStructureOutDTO> {
        return ResponseEntity.ok(structureService.create(dto, getAuthenticatedUser()))
    }

    @PutMapping("/{structureId}")
    fun update(@RequestHeader(X_TOKEN) token: String,
               @PathVariable structureId: String,
               @RequestBody dto: AdminStructureInDTO
    ): ResponseEntity<AdminStructureOutDTO> {
        return ResponseEntity.ok(structureService.update(structureId, dto, getAuthenticatedUser()))
    }

    @GetMapping("/{structureId}")
    fun get(@RequestHeader(X_TOKEN) token: String,
            @PathVariable structureId: String
    ): ResponseEntity<AdminStructureOutDTO> {
        return ResponseEntity.ok(structureService.get(structureId))
    }

    @DeleteMapping("/{structureId}")
    fun delete(@RequestHeader(X_TOKEN) token: String,
               @PathVariable structureId: String
    ): ResponseEntity<String> {
        val id = structureService.delete(structureId, getAuthenticatedUser())
        return ResponseEntity.ok(id)
    }
}
