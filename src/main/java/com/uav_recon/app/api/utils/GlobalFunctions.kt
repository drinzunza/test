package com.uav_recon.app.api.utils

import com.uav_recon.app.api.entities.Response
import com.uav_recon.app.api.utils.DateExtensions.Companion.DEFAULT_FORMAT
import java.text.DateFormat
import java.text.SimpleDateFormat
import java.util.*

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

fun <T> T.response(): Response<T> {
    return Response(this)
}

val emptyResponse = Response<Any>()

fun Date?.formatDate(formatter: DateFormat = DEFAULT_FORMAT): String? {
    this?.let {
        return formatter.format(this)
    }
    return null
}
