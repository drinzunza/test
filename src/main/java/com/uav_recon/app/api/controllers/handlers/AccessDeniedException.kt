package com.uav_recon.app.api.controllers.handlers

open class AccessDeniedException(
        val errorCode: Int = Exceptions.ACCESS_DENIED,
        override val message: String = Exceptions.message(Exceptions.ACCESS_DENIED)
) : RuntimeException(message)