package com.uav_recon.app.api.controllers.handlers

import com.uav_recon.app.api.controllers.handlers.Exceptions.NOT_AUTHORIZED

open class UnauthorizedException(
        val errorCode: Int = NOT_AUTHORIZED,
        override val message: String = Exceptions.message(NOT_AUTHORIZED)
) : RuntimeException(message)