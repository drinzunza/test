package com.uav_recon.app.api.controllers

import com.uav_recon.app.api.entities.requests.bridge.ProjectDto
import com.uav_recon.app.api.entities.requests.bridge.ProjectIdsDto
import com.uav_recon.app.api.services.ProjectService
import com.uav_recon.app.configurations.ControllerConfiguration.VERSION
import com.uav_recon.app.configurations.ControllerConfiguration.X_TOKEN
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*

@RestController
@RequestMapping("$VERSION/projects")
class ProjectController(private val projectsService: ProjectService) : BaseController() {

    @GetMapping
    fun getProjects(@RequestHeader(X_TOKEN) token: String, @RequestParam(required = false) companyId: Long?): ResponseEntity<List<ProjectDto>> {
        return ResponseEntity.ok(projectsService.listNotDeleted(getAuthenticatedUser(), companyId))
    }

    @GetMapping("/{id}")
    fun getProject(@RequestHeader(X_TOKEN) token: String, @PathVariable id: Long): ResponseEntity<ProjectDto> {
        return ResponseEntity.ok(projectsService.getNotDeleted(getAuthenticatedUser(), id))
    }

    @PostMapping("/save")
    fun saveProject(@RequestHeader(X_TOKEN) token: String, @RequestBody body: ProjectIdsDto): ResponseEntity<ProjectDto> {
        return ResponseEntity.ok(projectsService.save(getAuthenticatedUser(), body))
    }

    @DeleteMapping("/delete")
    fun deleteProject(@RequestHeader(X_TOKEN) token: String, @RequestParam id: Long): ResponseEntity<*> {
        projectsService.delete(getAuthenticatedUser(), id)
        return ResponseEntity.ok(success)
    }
}