package com.uav_recon.app.api.utils

import com.uav_recon.app.api.entities.Response

fun <T> T.response(): Response<T> {
    return Response(this)
}

val emptyResponse = Response<Any>()