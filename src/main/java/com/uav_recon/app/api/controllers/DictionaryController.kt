package com.uav_recon.app.api.controllers

import com.uav_recon.app.api.entities.requests.bridge.DictionaryDto
import com.uav_recon.app.api.repositories.EtagRepository
import com.uav_recon.app.api.services.DictionaryService
import com.uav_recon.app.configurations.ControllerConfiguration.ETAG
import com.uav_recon.app.configurations.ControllerConfiguration.IF_NONE_MATCH
import com.uav_recon.app.configurations.ControllerConfiguration.VERSION
import com.uav_recon.app.configurations.ControllerConfiguration.X_TOKEN
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestHeader
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping("${VERSION}/structures")
class DictionaryController(private val dictionaryService: DictionaryService) : BaseController() {

    @GetMapping
    fun get(@RequestHeader(X_TOKEN) token: String,
            @RequestHeader(IF_NONE_MATCH, required = false, defaultValue = "") etag: String
    ): ResponseEntity<DictionaryDto> {
        val lastEtagHash = dictionaryService.getLastEtagHash()
        return if (lastEtagHash == etag) {
            ResponseEntity.status(HttpStatus.NOT_MODIFIED).body(null)
        } else {
            ResponseEntity.ok().header(ETAG, etag)
                    .body(dictionaryService.getAll(etag, getAuthenticatedUserId()))
        }
    }
}