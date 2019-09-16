package com.uav_recon.app.api.controllers

import com.uav_recon.app.configurations.ControllerConfiguration.VERSION
import com.uav_recon.app.api.entities.Response
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RestController

@RestController
class TestController() {

    @GetMapping("$VERSION/test")
    fun test(): Response<*> {
        return Response<Any>()
    }
}