package com.uav_recon.app.api.controllers

import com.uav_recon.app.api.entities.db.BuildType
import com.uav_recon.app.api.entities.requests.bridge.*
import com.uav_recon.app.api.services.DictionaryService
import com.uav_recon.app.configurations.ControllerConfiguration.BUILD_TYPE
import com.uav_recon.app.configurations.ControllerConfiguration.ETAG
import com.uav_recon.app.configurations.ControllerConfiguration.VERSION
import com.uav_recon.app.configurations.ControllerConfiguration.VERSION2
import com.uav_recon.app.configurations.ControllerConfiguration.VERSION_CODE
import com.uav_recon.app.configurations.ControllerConfiguration.X_TOKEN
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*

@RestController
@RequestMapping("")
class DictionaryController(private val dictionaryService: DictionaryService) : BaseController() {

    @GetMapping("$VERSION/structures")
    fun get(@RequestHeader(X_TOKEN) token: String,
            @RequestHeader(ETAG, required = false, defaultValue = "") etag: String,
            @RequestHeader(BUILD_TYPE, required = false, defaultValue = "") buildType: String,
            @RequestHeader(VERSION_CODE, required = false, defaultValue = "") versionCode: String
    ): ResponseEntity<DictionaryDto> {
        val fixETag = etag.removePrefix("\"").removeSuffix("\"")

        val lastEtagHash = dictionaryService.getLastEtagHash()
        return if (lastEtagHash == fixETag) {
            ResponseEntity.status(HttpStatus.NOT_MODIFIED).header(ETAG, lastEtagHash)
                    .body(null)
        } else {
            val tempEtag = if (versionCode.isNotEmpty()) lastEtagHash else fixETag
            ResponseEntity.ok().header(ETAG, tempEtag)
                    .body(dictionaryService.getEtagChanges(getAuthenticatedUser(), fixETag, BuildType.parse(buildType), listOf()))
        }
    }

    @PostMapping("$VERSION/structures")
    fun getWithModified(@RequestHeader(X_TOKEN) token: String,
                        @RequestHeader(ETAG, required = false, defaultValue = "") etag: String,
                        @RequestHeader(BUILD_TYPE, required = false, defaultValue = "") buildType: String,
                        @RequestHeader(VERSION_CODE, required = false, defaultValue = "") versionCode: String,
                        @RequestBody body: StructureIdsDto
    ): ResponseEntity<DictionaryDto> {
        val fixETag = etag.removePrefix("\"").removeSuffix("\"")
        val lastEtagHash = dictionaryService.getLastEtagHash()
        val tempEtag = if (versionCode.isNotEmpty()) lastEtagHash else fixETag
        return ResponseEntity.ok().header(ETAG, tempEtag)
                .body(dictionaryService.getEtagChanges(
                        getAuthenticatedUser(), fixETag, BuildType.parse(buildType), body.structureIds
                ))
    }

    @PostMapping("$VERSION2/structures")
    fun getWithModified2(@RequestHeader(X_TOKEN) token: String,
                         @RequestHeader(ETAG, required = false, defaultValue = "") etag: String,
                         @RequestHeader(BUILD_TYPE, required = false, defaultValue = "") buildType: String,
                         @RequestHeader(VERSION_CODE, required = false, defaultValue = "") versionCode: String,
                         @RequestBody body: StructureIdsDto
    ): ResponseEntity<DictionaryDto> {
        return getWithModified(token, etag, buildType, versionCode, body)
    }

    /*@PostMapping("/structures")
    fun getWithModified(@RequestHeader(X_TOKEN) token: String,
            @RequestHeader(ETAG, required = false, defaultValue = "") etag: String,
            @RequestHeader(BUILD_TYPE, required = false, defaultValue = "") buildType: String,
            @RequestHeader(VERSION_CODE, required = false, defaultValue = "") versionCode: String,
            @RequestBody body: StructureIdsDto
    ): ResponseEntity<DictionaryDto> {
        val fixETag = etag.removePrefix("\"").removeSuffix("\"")

        val lastEtagHash = dictionaryService.getLastEtagHash()
        return if (lastEtagHash == fixETag) {
            ResponseEntity.status(HttpStatus.NOT_MODIFIED).header(ETAG, lastEtagHash)
                    .body(null)
        } else {
            val tempEtag = if (versionCode.isNotEmpty()) lastEtagHash else fixETag
            ResponseEntity.ok().header(ETAG, tempEtag)
                    .body(dictionaryService.getEtagChanges(fixETag, BuildType.parse(buildType)))
        }
    }*/

    /*fun getDictionaries(etag: String, buildType: String, versionCode: String, body: StructureIdsDto?): DictionaryDto {
        val fixETag = etag.removePrefix("\"").removeSuffix("\"")

        val lastEtagHash = dictionaryService.getLastEtagHash()
        return if (lastEtagHash == fixETag) {
            ResponseEntity.status(HttpStatus.NOT_MODIFIED).header(ETAG, lastEtagHash)
                    .body(null)
        } else {
            val tempEtag = if (versionCode.isNotEmpty()) lastEtagHash else fixETag
            ResponseEntity.ok().header(ETAG, tempEtag)
                    .body(dictionaryService.getAll(fixETag, BuildType.parse(buildType)))
        }
    }*/

    @GetMapping("$VERSION/dictionaries")
    fun getDictionaries(@RequestHeader(X_TOKEN) token: String): ResponseEntity<DictionariesDto> {
        return ResponseEntity.ok(dictionaryService.getDictionaries(getAuthenticatedUser()))
    }

    @PostMapping("$VERSION/dictionaries/save")
    fun saveDictionaries(@RequestHeader(X_TOKEN) token: String, @RequestBody body: DictionariesDto): ResponseEntity<DictionariesDto> {
        dictionaryService.saveDictionaries(getAuthenticatedUser(), body)
        dictionaryService.deleteNotUnique()
        return ResponseEntity.ok(dictionaryService.getDictionaries(getAuthenticatedUser()))
    }
}