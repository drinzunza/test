package com.uav_recon.app.api.controllers.handlers

import com.uav_recon.app.api.controllers.handlers.Exceptions.BAD_REQUEST
import com.uav_recon.app.api.controllers.handlers.Exceptions.ERROR
import com.uav_recon.app.api.entities.responses.Response
import com.uav_recon.app.api.services.Error
import org.apache.commons.lang3.exception.ExceptionUtils
import org.slf4j.LoggerFactory
import org.springframework.beans.factory.annotation.Value
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.ControllerAdvice
import org.springframework.web.bind.annotation.ExceptionHandler
import org.springframework.web.bind.annotation.ResponseBody
import org.springframework.web.bind.annotation.ResponseStatus
import javax.servlet.http.HttpServletRequest

@ControllerAdvice
class ExceptionsHandler(@Value("\${spring.profiles.active}") val profile: String) {
    private val logger = LoggerFactory.getLogger(ExceptionsHandler::class.java)

    @ResponseBody
    @ExceptionHandler(Exception::class)
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    fun handle(e: Exception, r: HttpServletRequest): Response<*> {
        if (logger.isErrorEnabled) {
            logger.error("Method call (`{}`) failed: {}.", r.requestURI, ExceptionUtils.getStackTrace(e))
        }
        return internalError(e.localizedMessage)
    }

    @ResponseBody
    @ExceptionHandler(Error::class)
    fun handle(e: Error, r: HttpServletRequest): ResponseEntity<*> {
        if (logger.isDebugEnabled) {
            logger.error("Method call (`{}`) failed: {}.", r.requestURI, ExceptionUtils.getStackTrace(e))
        } else {
            logger.error("Method call (`{}`) failed: {}.", r.requestURI, e.localizedMessage)
        }
        return ResponseEntity.badRequest().body(Response<Any>(e.code, e.message))
    }

    @ResponseBody
    @ExceptionHandler(UnauthorizedException::class)
    @ResponseStatus(HttpStatus.UNAUTHORIZED)
    fun handle(e: UnauthorizedException): Response<*> {
        return Response<Any>(e.errorCode, e.message)
    }

    @ResponseBody
    @ExceptionHandler(AccessDeniedException::class)
    @ResponseStatus(HttpStatus.FORBIDDEN)
    fun handle(e: AccessDeniedException): Response<*> {
        return Response<Any>(e.errorCode, e.message)
    }

    private fun internalError(reason: String?): Response<*> = Response<Any>().apply {
        code = ERROR
        message = reason ?: "An internal error occurred. Please contact the support group."
    }

    private fun badRequest(reason: String?): Response<*> = Response<Any>().apply {
        code = BAD_REQUEST
        message = reason ?: "Bad request"
    }
}
