package com.uav_recon.app.api.services

import com.fasterxml.jackson.databind.ObjectMapper
import com.uav_recon.app.api.entities.db.Photo
import com.uav_recon.app.api.entities.requests.bridge.Weather
import com.uav_recon.app.api.entities.requests.bridge.WeatherRequestDto
import com.uav_recon.app.api.entities.responses.bridge.WeatherResponseDto
import org.slf4j.LoggerFactory
import org.springframework.stereotype.Service
import java.lang.Exception
import java.net.URL
import kotlin.math.roundToInt

@Service
class WeatherService {
    private val api = "https://api.openweathermap.org/data/2.5/weather"
    private val historicalApi = "http://history.openweathermap.org/data/2.5/history/city"
    private val key = "7a224269d1bb365f86513331449a4e50"
    private val mapper = ObjectMapper()

    private val logger = LoggerFactory.getLogger(WeatherService::class.java)

    fun getWeather(latitude: Double?, longitude: Double?): Weather? {
        if (latitude == null || longitude == null) {
            return null
        }
        val resp = URL("${api}?lat=${latitude}&lon=${longitude}&appid=${key}&units=imperial").readText()
        val tree = mapper.readTree(resp)
        return Weather(tree.at("/main/temp").asDouble(),
                       tree.at("/main/humidity").asDouble(),
                       tree.at("/wind/speed").asDouble())
    }

    fun getHistoricalWeather(latitude: Double?, longitude: Double?, timestamp: Long?): Weather? {
        if (latitude == null || longitude == null || timestamp == null) {
            return null
        }
        return getHistoricalWeather(latitude, longitude, timestamp, true)
                ?: getHistoricalWeather(latitude, longitude, timestamp, false)
    }

    fun getHistoricalWeather(latitude: Double?, longitude: Double?, timestamp: Long?, start: Boolean): Weather? {
        try {
            val url = "$historicalApi?lat=$latitude&lon=$longitude&${if (start) "start" else "end"}=$timestamp&cnt=1&appid=$key"
            logger.info("Request weather $url")
            val resp = URL(url).readText()
            val tree = mapper.readTree(resp)
            val temp = ((tree.at("/list/0/main/temp").asDouble() * 9 / 5 - 459.67) * 100)
                    .roundToInt() / 100.0
            val weather = Weather(temp,
                    tree.at("/list/0/main/humidity").asDouble(),
                    tree.at("/list/0/wind/speed").asDouble())
            logger.info("Got weather ${weather.temperature}, ${weather.humidity}, ${weather.wind}")
            return weather
        } catch (e: Exception) {
            logger.error("Cannot get weather", e)
        }
        return null
    }

    fun getWeatherResponses(requests: List<WeatherRequestDto>): List<WeatherResponseDto> {
        val responses = mutableListOf<WeatherResponseDto>()
        requests.forEach {
            val weather = getHistoricalWeather(
                    it.location.latitude, it.location.longitude, it.date.toEpochSecond()
            )
            if (weather != null) {
                responses.add(WeatherResponseDto(it.id, weather))
            }
        }
        return responses
    }

    fun getWeatherByPhoto(photo: Photo) = getHistoricalWeather(
            photo.latitude, photo.longitude, photo.createdAtClient?.toEpochSecond()
    )
}
