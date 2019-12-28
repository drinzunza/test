package com.uav_recon.app.api.controllers

import com.uav_recon.app.api.entities.requests.bridge.WeatherRequestDto
import com.uav_recon.app.api.services.WeatherService
import com.uav_recon.app.configurations.ControllerConfiguration.VERSION
import com.uav_recon.app.configurations.ControllerConfiguration.X_TOKEN
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*

@RestController
@RequestMapping("${VERSION}/weather")
class WeatherController(private val weatherService: WeatherService) {

    @PostMapping
    fun get(@RequestHeader(X_TOKEN) token: String,
            @RequestBody requests: List<WeatherRequestDto>
    ) = ResponseEntity.ok(weatherService.getWeatherResponses(requests))
}