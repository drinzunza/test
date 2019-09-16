package com.uav_recon.app.api.controllers.handlers

object Exceptions {

    val BAD_REQUEST = 400
    val NOT_AUTHORIZED = 401
    val ERROR = 500

    private val map = mapOf(
            BAD_REQUEST to "Bad request",
            ERROR to "Not found",
            NOT_AUTHORIZED to "Not authorized"
    )

    fun message(code: Int): String {
        return map[code] ?: map[ERROR]!!
    }
}
