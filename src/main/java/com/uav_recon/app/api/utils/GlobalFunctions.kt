package com.uav_recon.app.api.utils

import com.uav_recon.app.api.entities.responses.Response
import org.springframework.core.io.Resource
import java.io.IOException
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
