package com.uav_recon.app.api.entities.responses.bridge

import com.fasterxml.jackson.annotation.JsonInclude
import com.uav_recon.app.api.entities.requests.bridge.Weather
import java.io.Serializable

@JsonInclude(JsonInclude.Include.NON_NULL)
data class WeatherResponseDto(
        val id: String,
        val weather: Weather
) : Serializable