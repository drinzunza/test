package com.uav_recon.app.api.controllers

import com.uav_recon.app.api.entities.requests.bridge.InspectionDto
import com.uav_recon.app.api.entities.requests.bridge.ProjectDto
import com.uav_recon.app.api.services.ProjectService
import com.uav_recon.app.configurations.ControllerConfiguration.VERSION
import com.uav_recon.app.configurations.ControllerConfiguration.X_TOKEN
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*

@RestController
@RequestMapping("$VERSION/projects")
class ProjectController(private val projectsService: ProjectService) : BaseController() {

    @GetMapping
    fun getProjects(@RequestHeader(X_TOKEN) token: String, @RequestParam companyId: Long?): ResponseEntity<List<ProjectDto>> {
        return ResponseEntity.ok(projectsService.listNotDeleted(getAuthenticatedUser(), companyId))
    }

    /*@PostMapping
    fun addProject(@RequestHeader(X_TOKEN) token: String, @RequestBody body: ProjectDto): ResponseEntity<InspectionDto> {
        return ResponseEntity.ok(projectsService.save(body, getAuthenticatedUserId()))
    }

    @DeleteMapping("/{uuid}")
    fun delete(@RequestHeader(X_TOKEN) token: String, @PathVariable uuid: String): ResponseEntity<*> {
        inspectionService.delete(uuid)
        return ResponseEntity.ok(success)
    }*/
}