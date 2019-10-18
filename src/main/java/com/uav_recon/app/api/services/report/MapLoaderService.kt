package com.uav_recon.app.api.services.report

import com.uav_recon.app.api.entities.db.Inspection
import com.uav_recon.app.api.entities.db.Observation
import com.uav_recon.app.api.entities.db.ObservationDefects
import com.uav_recon.app.api.entities.db.Photo
import org.springframework.http.HttpEntity
import org.springframework.http.HttpHeaders
import org.springframework.http.HttpMethod
import org.springframework.stereotype.Service
import org.springframework.web.client.RestTemplate
import java.io.InputStream
import java.util.*

private const val DEFAULT_WIDTH = 640
private const val DEFAULT_HEIGHT = 400
private const val API_KEY = "AIzaSyC8F-m4w3Ge0m849fzy4TtBwZU07vl0Bs4"
private const val IMAGE_URL_FORMAT =
        "https://maps.googleapis.com/maps/api/staticmap?size=%dx%d&markers=%s&key=%s&maptype=satellite"
private const val MARKER_FORMAT = "|%.5f,%.5f"
private const val DEFAULT_COLOR = "color:red"

@Service
class MapLoaderService {

    fun loadImage(inspection: Inspection): InputStream? {
        try {
            val url = String.format(
                    Locale.getDefault(),
                    IMAGE_URL_FORMAT,
                    DEFAULT_WIDTH,
                    DEFAULT_HEIGHT,
                    getMarkers(inspection),
                    API_KEY
            )
            return loadUrl(url)?.inputStream()
        } catch (e: Exception) {
            e.printStackTrace()
        }
        return null
    }

    private fun getMarkers(inspection: Inspection): String {
        val builder = StringBuilder(DEFAULT_COLOR)
        val observations: List<Observation> = listOf()
        observations.forEach { observation ->
            val defects: List<ObservationDefects> = listOf()
            defects.forEach { defect ->
                val photos: List<Photo> = listOf()
                val photo = photos.firstOrNull { it.latitude != null && it.longitude != null }
                photo?.let {
                    builder.append(String.format(MARKER_FORMAT, it.latitude, it.longitude))
                }
            }
        }
        return builder.toString()
    }

    fun loadUrl(url: String): ByteArray? {
        val restTemplate = RestTemplate()
        val headers = HttpHeaders()
        val entity = HttpEntity("", headers)
        val response = restTemplate.exchange(url, HttpMethod.GET, entity, ByteArray::class.java)
        return response.body
    }
}