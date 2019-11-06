package com.uav_recon.app.configurations

import com.fasterxml.jackson.databind.ObjectMapper
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder
import org.springframework.security.config.annotation.web.builders.HttpSecurity
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter
import org.springframework.security.config.http.SessionCreationPolicy
import org.springframework.security.core.AuthenticationException
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder
import org.springframework.security.crypto.password.PasswordEncoder
import org.springframework.security.web.AuthenticationEntryPoint
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter
import java.io.IOException
import javax.servlet.ServletException
import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpServletResponse


@Configuration
@EnableWebSecurity
class SecurityConfiguration(val tokenManager: TokenManager) : WebSecurityConfigurerAdapter() {
    private val AUTH_PATH = "/auth/**"
    private val API_PATH_PATTERN = "/api/**"

    @Throws(Exception::class)
    override fun configure(http: HttpSecurity) {
        val tokenAuthenticationFilter = TokenAuthenticationFilter(tokenManager, SkipPathRequestMatcher(listOf(AUTH_PATH)))
        http.csrf().disable().sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS)
                .and().authorizeRequests().antMatchers(AUTH_PATH).permitAll().antMatchers(API_PATH_PATTERN).authenticated().anyRequest().authenticated()
                .and().exceptionHandling().authenticationEntryPoint(CustomAuthenticationEntryPoint())
                .and().addFilterBefore(tokenAuthenticationFilter, UsernamePasswordAuthenticationFilter::class.java)

    }

    override fun configure(auth: AuthenticationManagerBuilder) {
        auth.authenticationProvider(TokenAuthenticationProvider())
    }

    @Bean
    fun passwordEncoder(): PasswordEncoder {
        return BCryptPasswordEncoder()
    }

    inner class CustomAuthenticationEntryPoint : AuthenticationEntryPoint {
        private val mapper = ObjectMapper()

        @Throws(IOException::class, ServletException::class)
        override fun commence(req: HttpServletRequest, res: HttpServletResponse, authException: AuthenticationException) {
            res.contentType = "application/json;charset=UTF-8"
            res.status = 403
            res.writer.write(mapper.writeValueAsString(mapOf(Pair("code", 403), Pair("message", "Access denied"))))
            res.writer.flush()
        }
    }
}

