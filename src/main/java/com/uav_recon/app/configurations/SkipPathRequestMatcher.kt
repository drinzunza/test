package com.uav_recon.app.configurations

import org.apache.commons.collections4.CollectionUtils
import org.apache.commons.lang3.StringUtils
import org.springframework.security.web.util.matcher.AntPathRequestMatcher
import org.springframework.security.web.util.matcher.OrRequestMatcher
import org.springframework.security.web.util.matcher.RequestMatcher
import java.util.stream.Collectors
import javax.servlet.http.HttpServletRequest


class SkipPathRequestMatcher(pathsToSkip: List<String>) : RequestMatcher {
    private var matcher: OrRequestMatcher

    init {
        require(!CollectionUtils.isEmpty(pathsToSkip)) { "pathsToSkip must be not empty" }
        require(!pathsToSkip.stream().anyMatch { s -> StringUtils.isEmpty(s) }) { "elements in pathsToSkip must be not empty" }
        val m: List<RequestMatcher> = pathsToSkip.stream().map { s -> AntPathRequestMatcher(s) }.collect(Collectors.toList())
        matcher = OrRequestMatcher(m)
    }

    override fun matches(httpServletRequest: HttpServletRequest): Boolean {
        return !matcher.matches(httpServletRequest)
    }
}
