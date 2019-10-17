package com.uav_recon.app.api.controllers

import com.uav_recon.app.api.entities.db.Inspection
import com.uav_recon.app.api.entities.responses.Response
import com.uav_recon.app.configurations.ControllerConfiguration.VERSION
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RestController

@RestController
class InspectionController {

    @GetMapping("$VERSION/inspection")
    fun getInspection(@RequestBody inspectionId: Int): Response<Inspection> {
        return Response()
    }

    @PostMapping("$VERSION/inspection")
    fun setInspection(@RequestBody inspection: Inspection): Response<Int> {
        return Response()
    }
}