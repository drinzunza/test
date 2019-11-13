package com.uav_recon.app.api.services

import com.fasterxml.jackson.databind.ObjectMapper
import com.uav_recon.app.api.entities.requests.bridge.Weather
import org.springframework.stereotype.Service
import java.net.URL

@Service
class WeatherService {
    private val api = "https://api.openweathermap.org/data/2.5/weather"
    private val key = "e364f201ab56e97036bdc5b8ceda64da"
    private val mapper = ObjectMapper()

    fun getWeather(latitude: Double?, longitude: Double?): Weather? {
        if(latitude == null || longitude == null) {
            return null
        }
        val resp = URL("${api}?lat=${latitude}&lon=${longitude}&appid=${key}&units=imperial").readText()
        val tree = mapper.readTree(resp)
        return Weather(tree.at("/main/temp").asDouble(),
                       tree.at("/main/humidity").asDouble(),
                       tree.at("/wind/speed").asDouble())
    }

}
