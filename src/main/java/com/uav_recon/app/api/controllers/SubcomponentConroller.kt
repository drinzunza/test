package com.uav_recon.app.api.controllers

import com.uav_recon.app.api.entities.requests.bridge.SubcomponentDto
import com.uav_recon.app.api.entities.responses.bridge.SubcomponentHealthDto
import com.uav_recon.app.api.services.SubcomponentService
import com.uav_recon.app.configurations.ControllerConfiguration.VERSION
import com.uav_recon.app.configurations.ControllerConfiguration.X_TOKEN
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*

@RestController
class SubcomponentConroller(private val subcomponentService: SubcomponentService) : BaseController() {

    @GetMapping("${VERSION}/subcomponents")
    fun get(@RequestHeader(X_TOKEN) token: String,
            @RequestParam(required = false) companyId: Long?,
            @RequestParam(required = false) structureId: String?
    ): ResponseEntity<List<SubcomponentHealthDto>> {
        return ResponseEntity.ok(subcomponentService.listNotDeleted(getAuthenticatedUser(), companyId, structureId))
    }
}
