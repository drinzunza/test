package com.uav_recon.app.api.controllers

import com.uav_recon.app.api.entities.requests.bridge.TemplateDto
import com.uav_recon.app.api.services.TemplateService
import com.uav_recon.app.configurations.ControllerConfiguration.VERSION
import com.uav_recon.app.configurations.ControllerConfiguration.X_TOKEN
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*

@RestController
@RequestMapping("$VERSION/templates")
class TemplateController(private val templateService: TemplateService) : BaseController() {

    @GetMapping
    fun getTemplates(@RequestHeader(X_TOKEN) token: String): ResponseEntity<List<TemplateDto>> {
        return ResponseEntity.ok(templateService.listNotDeleted(getAuthenticatedUser()))
    }

    @GetMapping("/{id}")
    fun getTemplate(@RequestHeader(X_TOKEN) token: String, @PathVariable id: Long): ResponseEntity<TemplateDto> {
        return ResponseEntity.ok(templateService.getNotDeleted(getAuthenticatedUser(), id))
    }

    @PostMapping("/save")
    fun saveTemplate(@RequestHeader(X_TOKEN) token: String, @RequestBody body: TemplateDto): ResponseEntity<TemplateDto> {
        return ResponseEntity.ok(templateService.save(getAuthenticatedUser(), body))
    }

    @DeleteMapping("/{id}")
    fun deleteTemplate(@RequestHeader(X_TOKEN) token: String, @PathVariable id: Long): ResponseEntity<*> {
        templateService.delete(getAuthenticatedUser(), id)
        return ResponseEntity.ok(success)
    }
}