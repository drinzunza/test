package com.uav_recon.app.api.controllers

import com.uav_recon.app.api.entities.responses.Response
import com.uav_recon.app.api.services.SyncService
import com.uav_recon.app.configurations.ControllerConfiguration.VERSION
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RestController

@RestController
class SyncController(private val syncService: SyncService) {

    @GetMapping("$VERSION/syncAssets")
    fun syncAssets(): Response<Any> {
        return Response()
    }

    @PostMapping("$VERSION/syncInspections")
    fun syncInspections(): Response<Any> {
        return Response()
    }
}