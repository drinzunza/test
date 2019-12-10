package com.uav_recon.app.api.controllers

import com.uav_recon.app.api.entities.db.BuildType
import com.uav_recon.app.api.entities.requests.bridge.DictionaryDto
import com.uav_recon.app.api.services.DictionaryService
import com.uav_recon.app.configurations.ControllerConfiguration.BUILD_TYPE
import com.uav_recon.app.configurations.ControllerConfiguration.ETAG
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
            @RequestHeader(ETAG, required = false, defaultValue = "") etag: String,
            @RequestHeader(BUILD_TYPE, required = false, defaultValue = "") buildType: String
    ): ResponseEntity<DictionaryDto> {
        val fixETag = etag.removePrefix("\"").removeSuffix("\"")

        val lastEtagHash = dictionaryService.getLastEtagHash()
        return if (lastEtagHash == fixETag) {
            ResponseEntity.status(HttpStatus.NOT_MODIFIED).header(ETAG, lastEtagHash)
                    .body(null)
        } else {
            ResponseEntity.ok().header(ETAG, lastEtagHash)
                    .body(dictionaryService.getAll(fixETag, BuildType.parse(buildType)))
        }
    }
}