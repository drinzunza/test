package com.uav_recon.app.api.services.report

import com.uav_recon.app.api.entities.db.Inspection
import com.uav_recon.app.api.entities.db.Location
import org.springframework.http.HttpEntity
import org.springframework.http.HttpHeaders
import org.springframework.http.HttpMethod
import org.springframework.stereotype.Service
import org.springframework.web.client.RestTemplate
import java.io.InputStream
import java.util.*

private const val DEFAULT_ZOOM = 15f
private const val DEFAULT_WIDTH = 640
private const val DEFAULT_HEIGHT = 400
private const val KEY = "AIzaSyByRNcBd0mi9rGgf9yUfvpS8RaiBixfGog"
private const val IMAGE_URL_FORMAT =
        "https://maps.googleapis.com/maps/api/staticmap?center=%.5f,%.5f&zoom=%.2f&size=%dx%d&markers=color:red|%.5f,%.5f&key=%s"

@Service
class MapLoaderService {

    fun loadImage(inspection: Inspection): InputStream? {
        val location = inspection.location
        return loadImage(location)
    }

    fun loadImage(location: Location) = loadImage(location.latitude, location.longitude)

    fun loadImage(latitude: Double?, longitude: Double?): InputStream? {
        val url = createUrl(latitude, longitude)
        val data = loadUrl(url)
        return data?.inputStream()
    }

    fun loadUrl(url: String): ByteArray? {
        val restTemplate = RestTemplate()
        val headers = HttpHeaders()
        val entity = HttpEntity("", headers)
        val response = restTemplate.exchange(url, HttpMethod.GET, entity, ByteArray::class.java)
        return response.body
    }

    private fun createUrl(
            latitude: Double?,
            longitude: Double?,
            width: Int = DEFAULT_WIDTH,
            height: Int = DEFAULT_HEIGHT,
            zoom: Float = DEFAULT_ZOOM
    ): String {
        return String.format(
                Locale.getDefault(), IMAGE_URL_FORMAT, latitude, longitude,
                zoom, width, height, latitude, longitude, KEY
        )
    }
}