package com.uav_recon.app.api.controllers

import com.google.api.client.util.IOUtils
import com.uav_recon.app.api.entities.requests.bridge.InspectionDto
import com.uav_recon.app.api.repositories.PhotoRepository
import com.uav_recon.app.api.services.FileService
import com.uav_recon.app.api.services.InspectionService
import org.springframework.http.MediaType
import org.springframework.stereotype.Controller
import org.springframework.ui.Model
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.RequestMapping
import java.io.ByteArrayInputStream
import java.io.IOException
import java.util.*
import javax.servlet.http.HttpServletResponse
import javax.servlet.http.HttpSession
import kotlin.collections.ArrayList

@Controller
@RequestMapping("datarecon/{userId}")
class PublicLinksController(
        private val inspectionService: InspectionService,
        private val fileService: FileService,
        private val photoRepository: PhotoRepository
) {
    val errorMessageAttribute = "errorMessage"

    @GetMapping("/{inspectionId}")
    fun inspection(@PathVariable userId: Long, @PathVariable inspectionId: String, model: Model, session: HttpSession):
            String {
        populateModel(userId, inspectionId, model, session)
        return getView(model)
    }

    @GetMapping("/{inspectionId}/{observationId}")
    fun observation(@PathVariable userId: Long, @PathVariable inspectionId: String, @PathVariable observationId:
    String, model: Model, session: HttpSession): String {
        populateModel(userId, inspectionId, model, session, observationId)
        return getView(model)
    }

    @GetMapping("/{inspectionId}/{observationId}/{observationDefectId}")
    fun observationDefect(@PathVariable userId: Long, @PathVariable inspectionId: String, @PathVariable
    observationId: String, @PathVariable observationDefectId: String, model: Model, session: HttpSession): String {
        populateModel(userId, inspectionId, model, session, observationId, observationDefectId)
        return getView(model)
    }

    @GetMapping("/{inspectionId}/{observationId}/{observationDefectId}/{photoName}")
    @Throws(IOException::class)
    fun getImageAsByteArray(@PathVariable userId: Long, @PathVariable inspectionId: String, @PathVariable
        observationId: String, @PathVariable observationDefectId: String, @PathVariable
                            photoName: String, response: HttpServletResponse, session: HttpSession) {
        val optional = getInspection(inspectionId, session)
        if (optional.isPresent) {
            val observations = optional.get().observations?.filter { o -> o.id == observationId }
            if (observations != null && observations.size == 1) {
                val defects = observations[0].observationDefects?.filter { d -> d.id == observationDefectId }
                if (defects != null && defects.size == 1) {
                    val photos = defects[0].photos?.filter { p -> p.name == photoName }
                    if (photos != null && photos.size == 1) {
                        response.contentType = MediaType.IMAGE_JPEG_VALUE
                        IOUtils.copy(ByteArrayInputStream(
                                fileService.get(photos[0].link!!, photos[0].drawables, true)), response.outputStream)
                    }
                }
            }
        }

    }

    private fun getView(model: Model): String {
        return if (model.getAttribute(errorMessageAttribute) != null) {
            "error"
        } else {
            "base";
        }
    }

    fun getInspection(inspectionId: String, session: HttpSession): Optional<InspectionDto> {
        val sessionInspectionAttribute = "inspection"
        val sessionInspection = session.getAttribute(sessionInspectionAttribute)
        if (sessionInspection != null && (sessionInspection as InspectionDto).uuid == inspectionId) {
            return Optional.of(sessionInspection)
        } else {
            val optional = inspectionService.findById(inspectionId)
            if (optional.isPresent) {
                session.setAttribute(sessionInspectionAttribute, optional.get())
            }
            return optional
        }
    }

    private fun populateModel(userId: Long, inspectionId: String,
                              model: Model,
                              session: HttpSession,
                              observationId: String? = null,
                              observationDefectId: String? = null) {
        val title: String?
        val header: String?
        val items: List<Any>?
        val parents = ArrayList<Parent>()

        val optional = getInspection(inspectionId, session)
        if (!optional.isPresent) {
            model.addAttribute(errorMessageAttribute, "Invalid inspection id")
            return
        }
        val inspectionDto = optional.get()

        val inspectionUrl = "/datarecon/$userId/$inspectionId"
        parents.add(Parent(inspectionUrl, "Inspection $inspectionId"))
        if (observationId == null) {
            title = "Inspection ${inspectionDto.uuid}"
            header = "Observations"
            items = inspectionDto.observations
        } else {
            val observations = inspectionDto.observations?.filter { o -> o.id == observationId }
            if (observations == null || observations.isEmpty()) {
                model.addAttribute(errorMessageAttribute, "Invalid observation id")
                return
            }

            if (observations.size > 1) {
                model.addAttribute(errorMessageAttribute,
                                   "There are more then one observation with id $observationId. " +
                                           "Please contact Administrator")
                return
            }

            val observation = observations[0]

            val observationUrl = "$inspectionUrl/$observationId"
            parents.add(Parent(observationUrl, "Observation $observationId"))
            if (observationDefectId == null) {
                title = "Observation $observationId"
                header = "Defects"
                items = observation.observationDefects
            } else {
                val defects = observation.observationDefects?.filter { d -> d.id == observationDefectId }
                if (defects == null || defects.isEmpty()) {
                    model.addAttribute(errorMessageAttribute, "Invalid observation defect id")
                    return
                }
                if (defects.size > 1) {
                    model.addAttribute(errorMessageAttribute,
                                       "There are more then one observation defect with id $observationDefectId. " +
                                               "Please contact Administrator")
                    return
                }
                val defect = defects[0]
                parents.add(Parent("$observationUrl/$observationDefectId", "Observation defect $observationDefectId"))
                title = "Observation defect $observationDefectId"
                header = "Photos"
                items = defect.photos?.map { p -> Photo(p.name) }
                model.addAttribute("isPhotoList", true)
            }
        }
        model.addAttribute("title", title)
        model.addAttribute("header", header)
        model.addAttribute("items", items)
        model.addAttribute("parents", parents)
    }

    class Photo(val id: String?)

    class Parent(val url: String, val name: String)


}
