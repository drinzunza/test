package com.uav_recon.app.api.utils

import com.uav_recon.app.api.entities.responses.Response
import com.uav_recon.app.api.services.report.document.main.DefectFields
import com.uav_recon.app.api.utils.DateExtensions.Companion.DEFAULT_FORMAT
import org.springframework.core.io.Resource
import java.io.IOException
import java.text.DateFormat
import java.text.SimpleDateFormat
import java.time.OffsetDateTime
import java.util.*
import javax.servlet.http.HttpServletRequest

fun <T> T.response(): Response<T> {
    return Response(this)
}

fun Resource.getFileContentType(request: HttpServletRequest): String {
    var contentType: String? = null
    try {
        contentType = request.servletContext.getMimeType(this.file.absolutePath)
    } catch (ex: IOException) {
        println("Could not determine file type.")
    }

    if (contentType == null) {
        contentType = "application/octet-stream"
    }
    return contentType
}

class DateExtensions {

    companion object {
        internal val HOURS_AND_MINS_FORMAT = SimpleDateFormat("HH:mm", Locale.getDefault())
        internal val DEFAULT_FORMAT = SimpleDateFormat("dd.MM.yyyy", Locale.getDefault())

        @JvmStatic
        fun createDate(year: Int, month: Int, day: Int): Date {
            val calendar = Calendar.getInstance()
            calendar.set(year, month, day)
            return calendar.time
        }
    }

}

fun Date?.formatDate(formatter: DateFormat = DEFAULT_FORMAT): String? {
    this?.let {
        return formatter.format(this)
    }
    return null
}

val <E : Enum<E>> Enum<E>.normalName: String
    get() = name[0] + name.substring(1).toLowerCase(Locale.US)

fun OffsetDateTime.toDate(): Date {
    return Date(toEpochSecond() * 1000)
}

fun OffsetDateTime?.formatDate(formatter: DateFormat = DEFAULT_FORMAT): String? {
    this?.let {
        return formatter.format(toDate())
    }
    return null
}