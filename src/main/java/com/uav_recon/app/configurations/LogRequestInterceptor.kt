package com.uav_recon.app.configurations

import org.slf4j.LoggerFactory
import org.springframework.stereotype.Component
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter
import java.time.Instant
import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpServletResponse

@Component
class LogRequestInterceptor : HandlerInterceptorAdapter() {

    companion object {
        private val logger = LoggerFactory.getLogger(LogRequestInterceptor::class.java)
    }

    override fun preHandle(request: HttpServletRequest?, response: HttpServletResponse?, handler: Any?): Boolean {
        val startTime = Instant.now().toEpochMilli()
        logger.info("${request?.method}::${request?.requestURL.toString()}:: IP=${request?.remoteAddr}")
        request?.setAttribute("startTime", startTime)
        return true
    }

    override fun afterCompletion(request: HttpServletRequest?, response: HttpServletResponse?, handler: Any?, ex: Exception?) {
        val startTime = (request?.getAttribute("startTime") ?: 0) as Long
        val time = Instant.now().toEpochMilli() - startTime
        logger.info("${request?.method}::${request?.requestURL.toString()}:: Time=$time ms, Code=${response?.status}")
    }
}