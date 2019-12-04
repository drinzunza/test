package com.uav_recon.app.api.controllers

import com.uav_recon.app.api.entities.requests.bridge.DictionaryDto
import com.uav_recon.app.api.services.DictionaryService
import com.uav_recon.app.configurations.ControllerConfiguration.VERSION
import com.uav_recon.app.configurations.ControllerConfiguration.X_TOKEN
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestHeader
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping("${VERSION}/structures")
class DictionaryController(private val dictionaryService: DictionaryService) : BaseController() {

    @GetMapping
    fun get(@RequestHeader(X_TOKEN) token: String): ResponseEntity<DictionaryDto> {
        return ResponseEntity.ok(dictionaryService.getAll(getAuthenticatedUserId()))
    }
}