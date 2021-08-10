package com.uav_recon.app.api.controllers

import com.google.api.client.util.IOUtils
import com.uav_recon.app.api.entities.requests.bridge.*
import com.uav_recon.app.api.entities.responses.bridge.InspectionUsersDto
import com.uav_recon.app.api.services.InspectionService
import com.uav_recon.app.configurations.ControllerConfiguration.VERSION
import com.uav_recon.app.configurations.ControllerConfiguration.VERSION2
import com.uav_recon.app.configurations.ControllerConfiguration.X_TOKEN
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*
import java.util.zip.ZipEntry
import java.util.zip.ZipOutputStream
import javax.servlet.http.HttpServletResponse

@RestController
class InspectionController(private val inspectionService: InspectionService) : BaseController() {
    private val OCTET_CONTENT_STREAM_CONTENT_TYPE = "application/octet-stream"
    // V2

    @GetMapping("$VERSION2/inspection")
    fun getV2(
        @RequestHeader(X_TOKEN) token: String,
        @RequestParam(required = false) projectId: Long?,
        @RequestParam(required = false) structureId: String?,
        @RequestParam(required = false) withObservations: Boolean?,
        @RequestParam(required = false) archived: Boolean?,
        @RequestParam(required = false) page: Int?,
        @RequestParam(required = false) count: Int?
    ): ResponseEntity<List<InspectionDtoV2>> {
        val inspections = inspectionService.listNotDeletedDto(
            getAuthenticatedUser(), projectId, structureId, null, withObservations ?: true
        ).filter { archived == null || it.archived == archived }
            .filterIndexed { index, inspectionDtoV2 ->
                if (page != null && count != null) index >= page * count && index < page * count + count else true
            }
        return ResponseEntity.ok(inspections)
    }


    @GetMapping("$VERSION2/downloadInspectionPhotosZip")
    fun getInspectionPhotosArchive(
        @RequestParam(required = true) structureId: String,
        @RequestParam(required = true) inspectionId: String,
        response: HttpServletResponse
    ) {
        response.contentType = OCTET_CONTENT_STREAM_CONTENT_TYPE;
        response.status = HttpServletResponse.SC_OK;
        val inspectionArchivePhotoDto = inspectionService.getPhotosArchiveData(structureId, inspectionId);
        response.setHeader(
            "Content-Disposition",
            "attachment;filename=${inspectionArchivePhotoDto.structureCode}-${inspectionArchivePhotoDto.structureName}.zip"
        )
        val zipOutputStream = ZipOutputStream(response.outputStream);
        inspectionArchivePhotoDto.photos.forEach { (stream, defectId, index) ->
            zipOutputStream.putNextEntry(ZipEntry("${defectId}_${index}"));
            stream.use { stream.copyTo(zipOutputStream) }
            zipOutputStream.closeEntry();
        }
        zipOutputStream.close();
    }

    @GetMapping("$VERSION2/inspection/{uuid}")
    fun getInspectionV2(
        @RequestHeader(X_TOKEN) token: String,
        @PathVariable uuid: String
    ): ResponseEntity<InspectionDtoV2> {
        return ResponseEntity.ok(inspectionService.getNotDeleted(getAuthenticatedUser(), uuid))
    }

    @PostMapping("$VERSION2/inspection/full")
    fun fullV2(
        @RequestHeader(X_TOKEN) token: String,
        @RequestBody body: InspectionDtoV2
    ): ResponseEntity<InspectionDtoV2> {
        return ResponseEntity.ok(inspectionService.save(getAuthenticatedUser(), body))
    }

    @PostMapping("$VERSION2/inspection")
    fun createOrUpdateV2(
        @RequestHeader(X_TOKEN) token: String,
        @RequestBody body: InspectionDtoV2
    ): ResponseEntity<InspectionDtoV2> {
        return ResponseEntity.ok(inspectionService.save(getAuthenticatedUser(), body))
    }

    @PostMapping("$VERSION2/inspection/summary")
    fun updateSummary(
        @RequestHeader(X_TOKEN) token: String,
        @RequestBody body: InspectionSummaryDto
    ): ResponseEntity<InspectionDtoV2> {
        return ResponseEntity.ok(inspectionService.updateSummary(body))
    }

    @PostMapping("$VERSION2/inspection/archive")
    fun updateArchive(
        @RequestHeader(X_TOKEN) token: String,
        @RequestBody body: InspectionArchiveDto
    ): ResponseEntity<InspectionDtoV2> {
        return ResponseEntity.ok(inspectionService.updateArchive(body))
    }

    @PatchMapping("$VERSION2/inspection/{uuid}")
    fun updateInspectionV2(
        @RequestHeader(X_TOKEN) token: String,
        @PathVariable uuid: String,
        @RequestBody body: InspectionUpdateDto
    ): ResponseEntity<InspectionDtoV2> {
        return ResponseEntity.ok(inspectionService.updateInspection(getAuthenticatedUser(), uuid, body))
    }

    // V1

    @Deprecated("Use v2 version")
    @GetMapping("$VERSION/inspection")
    fun get(
        @RequestHeader(X_TOKEN) token: String,
        @RequestParam(required = false) projectId: Long?,
        @RequestParam(required = false) structureId: String?,
        @RequestParam(required = false) withObservations: Boolean?
    ): ResponseEntity<List<InspectionDto>> {
        return ResponseEntity.ok(
            inspectionService.listNotDeletedDtoV1(
                getAuthenticatedUser(), projectId, structureId, null, withObservations ?: true
            )
        )
    }

    @Deprecated("Use v2 version")
    @GetMapping("$VERSION/inspection/{uuid}")
    fun getInspection(
        @RequestHeader(X_TOKEN) token: String,
        @PathVariable uuid: String
    ): ResponseEntity<InspectionDto> {
        return ResponseEntity.ok(inspectionService.getNotDeletedV1(getAuthenticatedUser(), uuid))
    }

    @Deprecated("Use v2 version")
    @PostMapping("$VERSION/inspection")
    fun createOrUpdate(
        @RequestHeader(X_TOKEN) token: String,
        @RequestBody body: InspectionDto
    ): ResponseEntity<InspectionDto> {
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
    fun getInspectors(
        @RequestHeader(X_TOKEN) token: String,
        @RequestParam id: String
    ): ResponseEntity<InspectionUserIdsDto> {
        return ResponseEntity.ok(inspectionService.getUserIds(getAuthenticatedUser(), id))
    }

    @PostMapping("$VERSION/inspection/inspectors")
    fun setInspectors(
        @RequestHeader(X_TOKEN) token: String,
        @RequestBody body: InspectionUserIdsDto
    ): ResponseEntity<InspectionUsersDto> {
        return ResponseEntity.ok(inspectionService.assignUsers(getAuthenticatedUser(), body))
    }
}
