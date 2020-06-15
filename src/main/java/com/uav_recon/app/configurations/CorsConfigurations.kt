package com.uav_recon.app.configurations

import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.http.HttpMethod
import org.springframework.http.HttpStatus
import org.springframework.web.cors.reactive.CorsUtils
import org.springframework.web.server.WebFilter
import reactor.core.publisher.Mono

@Configuration
class ReactiveConfigurations {

    companion object {
        const val ALLOWED_HEADERS = "*" //* = all
        const val ALLOWED_METHODS = "GET, PUT, POST, DELETE, OPTIONS, HEAD"
        const val ALLOWED_ORIGIN = "*"
        const val EXPOSED_HEADERS = "x-access_token, refresh_token, api-version, content-length, content-md5, content-type, date, request-id, response-time"
        const val MAX_AGE = "3600"
    }

    @Bean
    fun corsFilter(): WebFilter {
        return WebFilter { ctx, chain ->
            val request = ctx.request
            if (CorsUtils.isCorsRequest(request)) {
                val response = ctx.response
                val headers = response.headers
                headers.add("Access-Control-Allow-Origin", ALLOWED_ORIGIN)
                headers.add("Access-Control-Allow-Methods", ALLOWED_METHODS)
                headers.add("Access-Control-Max-Age", MAX_AGE)
                headers.add("Access-Control-Allow-Headers", ALLOWED_HEADERS)
                headers.add("Access-Control-Expose-Headers", EXPOSED_HEADERS)
                if (request.method === HttpMethod.OPTIONS) {
                    response.statusCode = HttpStatus.OK
                    return@WebFilter Mono.empty<Void>()
                }
            }
            chain.filter(ctx)
        }
    }
}
