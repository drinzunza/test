package com.uav_recon.app.configurations

import org.springframework.security.authentication.UsernamePasswordAuthenticationToken
import org.springframework.security.core.context.SecurityContextHolder
import org.springframework.security.web.util.matcher.RequestMatcher
import org.springframework.web.filter.OncePerRequestFilter
import javax.servlet.FilterChain
import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpServletResponse

class TokenAuthenticationFilter(
        private val manager: TokenManager,
        private val requestMatcher: RequestMatcher) : OncePerRequestFilter() {
    private val header = "X-Token"

    override fun shouldNotFilter(request: HttpServletRequest): Boolean {
        return !requestMatcher.matches(request) || super.shouldNotFilter(request)
    }

    override fun doFilterInternal(request: HttpServletRequest, response: HttpServletResponse, filterChain: FilterChain) {
        val token = request.getHeader(header)
        if (token != null && token.isNotBlank()) {
            val userId = manager.verifyAndExtractUserId(token)
            if (userId != null) {
                SecurityContextHolder.getContext().authentication = UsernamePasswordAuthenticationToken(userId, null)
            }
            SecurityContextHolder.getContext().authentication = null
        }
        filterChain.doFilter(request, response)
    }
}
