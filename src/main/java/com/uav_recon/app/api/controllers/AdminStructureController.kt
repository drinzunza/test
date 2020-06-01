package com.uav_recon.app.api.controllers

import com.uav_recon.app.api.controllers.dto.admin.AdminStructureInDTO
import com.uav_recon.app.api.controllers.dto.admin.AdminStructureOutDTO
import com.uav_recon.app.api.controllers.mapper.AdminStructureMapper
import com.uav_recon.app.api.services.StructureService
import com.uav_recon.app.configurations.ControllerConfiguration.VERSION
import com.uav_recon.app.configurations.ControllerConfiguration.X_TOKEN
import org.mapstruct.factory.Mappers
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*
import javax.validation.Valid

@RestController
@RequestMapping("${VERSION}/admin/structures")
class AdminStructureController(
        private val structureService: StructureService
) : BaseController() {
    private val structureMapper = Mappers.getMapper(AdminStructureMapper::class.java)

    @GetMapping
    fun list(@RequestHeader(X_TOKEN) token: String,
             @RequestParam(required = false) companyId: Long?
    ): ResponseEntity<List<AdminStructureOutDTO>> {
        val dtoList = structureService.listStructures(this.getAuthenticatedUser(), companyId).map { structureMapper.map(it) }
        return ResponseEntity.ok(dtoList)
    }

    @PostMapping
    fun create(@RequestHeader(X_TOKEN) token: String, @Valid @RequestBody dto: AdminStructureInDTO): ResponseEntity<AdminStructureOutDTO> {
        val structure = structureService.create(structureMapper.map(dto), this.getAuthenticatedUser())
        return ResponseEntity.ok(structureMapper.map(structure))
    }

    @PutMapping("/{structureId}")
    fun update(@RequestHeader(X_TOKEN) token: String, @PathVariable structureId: String, @RequestBody dto: AdminStructureInDTO):
            ResponseEntity<AdminStructureOutDTO> {
        val structure = structureService.update(structureId, structureMapper.map(dto), this.getAuthenticatedUser())
        return ResponseEntity.ok(structureMapper.map(structure))
    }

    @GetMapping("/{structureId}")
    fun get(@RequestHeader(X_TOKEN) token: String, @PathVariable structureId: String
    ): ResponseEntity<AdminStructureOutDTO> {
        val structure = structureService.get(structureId)
        return ResponseEntity.ok(structureMapper.map(structure))
    }

    @DeleteMapping("/{structureId}")
    fun delete(@RequestHeader(X_TOKEN) token: String, @PathVariable structureId: String
    ): ResponseEntity<String> {
        val id = structureService.delete(structureId, this.getAuthenticatedUser())
        return ResponseEntity.ok(id)
    }
}
