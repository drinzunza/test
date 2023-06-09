package com.uav_recon.app.api.services.report

import com.uav_recon.app.api.entities.db.Inspection
import com.uav_recon.app.api.repositories.ObservationDefectRepository
import com.uav_recon.app.api.repositories.ObservationRepository
import com.uav_recon.app.api.repositories.PhotoRepository
import org.springframework.http.HttpMethod
import org.springframework.stereotype.Service
import org.springframework.web.client.RestTemplate
import java.io.InputStream
import java.util.*

private const val DEFAULT_WIDTH = 640
private const val DEFAULT_HEIGHT = 400
private const val DEFAULT_ZOOM = 18
private const val API_KEY = "AIzaSyC8F-m4w3Ge0m849fzy4TtBwZU07vl0Bs4"
private const val IMAGE_URL_FORMAT = "https://maps.googleapis.com/maps/api/staticmap?size=%dx%d&zoom=%d&markers=%s&key=%s&maptype=satellite"
private const val MARKER_FORMAT = "|%.5f,%.5f"
private const val DEFAULT_COLOR = "color:red"

@Service
class MapLoaderService(
        private val observationRepository: ObservationRepository,
        private val observationDefectRepository: ObservationDefectRepository,
        private val photoRepository: PhotoRepository
) {

    fun loadImage(inspection: Inspection): InputStream? {
        val markers = getMarkers(inspection)
        try {
            val url = String.format(
                    Locale.getDefault(),
                    IMAGE_URL_FORMAT,
                    DEFAULT_WIDTH,
                    DEFAULT_HEIGHT,
                    DEFAULT_ZOOM,
                    markers,
                    API_KEY
            )
            return loadUrl(url)?.inputStream()
        } catch (e: Exception) {
            e.printStackTrace()
        }
        return null
    }

    private fun getMarkers(inspection: Inspection): String {
        var isMarkerAdded = false
        val builder = StringBuilder(DEFAULT_COLOR)
        observationRepository.findAllByInspectionIdAndDeletedIsFalse(inspection.uuid).forEach { observation ->
            observationDefectRepository.findAllByObservationIdAndDeletedIsFalse(observation.id).forEach { defect ->
                photoRepository.findAllByObservationDefectIdAndDeletedIsFalse(defect.id).firstOrNull {
                    it.latitude != null && it.longitude != null
                }?.let {
                    builder.append(String.format(MARKER_FORMAT, it.latitude, it.longitude))
                    isMarkerAdded = true
                }
            }
        }
        if (!isMarkerAdded && inspection.latitude != null && inspection.longitude != null) {
            builder.append(String.format(MARKER_FORMAT, inspection.latitude, inspection.longitude))
        }
        return builder.toString()
    }

    fun loadUrl(url: String): ByteArray? {
        return RestTemplate().exchange(url, HttpMethod.GET, null, ByteArray::class.java).body
    }
}
