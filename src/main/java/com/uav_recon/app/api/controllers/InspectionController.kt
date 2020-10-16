package com.uav_recon.app.api.controllers

import com.uav_recon.app.api.entities.requests.bridge.InspectionDto
import com.uav_recon.app.api.entities.requests.bridge.InspectionDtoV2
import com.uav_recon.app.api.entities.requests.bridge.InspectionSummaryDto
import com.uav_recon.app.api.entities.requests.bridge.InspectionUserIdsDto
import com.uav_recon.app.api.entities.responses.bridge.InspectionUsersDto
import com.uav_recon.app.api.services.InspectionService
import com.uav_recon.app.configurations.ControllerConfiguration.VERSION
import com.uav_recon.app.configurations.ControllerConfiguration.VERSION2
import com.uav_recon.app.configurations.ControllerConfiguration.X_TOKEN
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*

@RestController
class InspectionController(private val inspectionService: InspectionService) : BaseController() {

    // V2

    @GetMapping("$VERSION2/inspection")
    fun getV2(@RequestHeader(X_TOKEN) token: String,
            @RequestParam(required = false) projectId: Long?,
            @RequestParam(required = false) structureId: String?,
            @RequestParam(required = false) withObservations: Boolean?,
            @RequestParam(required = false) page: Int?,
            @RequestParam(required = false) count: Int?
    ): ResponseEntity<List<InspectionDtoV2>> {
        val inspections = inspectionService.listNotDeletedDto(
                getAuthenticatedUser(), projectId, structureId, null, withObservations ?: true
        ).filterIndexed { index, inspectionDtoV2 ->
            if (page != null && count != null) index >= page * count && index < page * count + count else true
        }
        return ResponseEntity.ok(inspections)
    }

    @GetMapping("$VERSION2/inspection/{uuid}")
    fun getInspectionV2(@RequestHeader(X_TOKEN) token: String, @PathVariable uuid: String): ResponseEntity<InspectionDtoV2> {
        return ResponseEntity.ok(inspectionService.getNotDeleted(getAuthenticatedUser(), uuid))
    }

    @PostMapping("$VERSION2/inspection/full")
    fun fullV2(@RequestHeader(X_TOKEN) token: String, @RequestBody body: InspectionDtoV2): ResponseEntity<InspectionDtoV2> {
        return ResponseEntity.ok(inspectionService.save(getAuthenticatedUser(), body))
    }

    @PostMapping("$VERSION2/inspection")
    fun createOrUpdateV2(@RequestHeader(X_TOKEN) token: String, @RequestBody body: InspectionDtoV2): ResponseEntity<InspectionDtoV2> {
        return ResponseEntity.ok(inspectionService.save(getAuthenticatedUser(), body))
    }

    @PostMapping("$VERSION2/inspection/summary")
    fun updateSummary(@RequestHeader(X_TOKEN) token: String, @RequestBody body: InspectionSummaryDto): ResponseEntity<InspectionDtoV2> {
        return ResponseEntity.ok(inspectionService.updateSummary(body))
    }

    // V1

    @Deprecated("Use v2 version")
    @GetMapping("$VERSION/inspection")
    fun get(@RequestHeader(X_TOKEN) token: String,
            @RequestParam(required = false) projectId: Long?,
            @RequestParam(required = false) structureId: String?,
            @RequestParam(required = false) withObservations: Boolean?
    ): ResponseEntity<List<InspectionDto>> {
        return ResponseEntity.ok(inspectionService.listNotDeletedDtoV1(
                getAuthenticatedUser(), projectId, structureId, null, withObservations ?: true
        ))
    }

    @Deprecated("Use v2 version")
    @GetMapping("$VERSION/inspection/{uuid}")
    fun getInspection(@RequestHeader(X_TOKEN) token: String, @PathVariable uuid: String): ResponseEntity<InspectionDto> {
        return ResponseEntity.ok(inspectionService.getNotDeletedV1(getAuthenticatedUser(), uuid))
    }

    @Deprecated("Use v2 version")
    @PostMapping("$VERSION/inspection")
    fun createOrUpdate(@RequestHeader(X_TOKEN) token: String, @RequestBody body: InspectionDto): ResponseEntity<InspectionDto> {
        return ResponseEntity.ok(inspectionService.saveV1(getAuthenticatedUser(), body))
    }

    @DeleteMapping("$VERSION/inspection/{uuid}")
    fun delete(@RequestHeader(X_TOKEN) token: String, @PathVariable uuid: String): ResponseEntity<*> {
        inspectionService.delete(getAuthenticatedUser(), uuid)
        return ResponseEntity.ok(success)
    }

    @Deprecated("Use v2 version")
    @PostMapping("$VERSION/inspection/full")
    fun full(@RequestHeader(X_TOKEN) token: String, @RequestBody body: InspectionDto): ResponseEntity<InspectionDto> {
        return ResponseEntity.ok(inspectionService.saveV1(getAuthenticatedUser(), body))
    }

    @GetMapping("$VERSION/inspection/inspectors")
    fun getInspectors(@RequestHeader(X_TOKEN) token: String, @RequestParam id: String): ResponseEntity<InspectionUserIdsDto> {
        return ResponseEntity.ok(inspectionService.getUserIds(getAuthenticatedUser(), id))
    }

    @PostMapping("$VERSION/inspection/inspectors")
    fun setInspectors(@RequestHeader(X_TOKEN) token: String, @RequestBody body: InspectionUserIdsDto): ResponseEntity<InspectionUsersDto> {
        return ResponseEntity.ok(inspectionService.assignUsers(getAuthenticatedUser(), body))
    }
}
