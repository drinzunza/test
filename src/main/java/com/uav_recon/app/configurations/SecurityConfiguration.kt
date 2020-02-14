package com.uav_recon.app.configurations

import com.fasterxml.jackson.databind.ObjectMapper
import com.uav_recon.app.api.services.UserService
import org.springframework.context.annotation.Configuration
import org.springframework.core.annotation.Order
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder
import org.springframework.security.config.annotation.web.builders.HttpSecurity
import org.springframework.security.config.annotation.web.builders.WebSecurity
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter
import org.springframework.security.config.http.SessionCreationPolicy
import org.springframework.security.core.AuthenticationException
import org.springframework.security.core.userdetails.UserDetailsService
import org.springframework.security.crypto.password.PasswordEncoder
import org.springframework.security.web.AuthenticationEntryPoint
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter
import java.io.IOException
import javax.servlet.ServletException
import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpServletResponse

@Configuration
@EnableWebSecurity
open class SecurityConfiguration {

    @Configuration
    @Order(1)
    open class ApiWebSecurityConfigurerAdapter(val tokenManager: TokenManager, val userService: UserService) :
            WebSecurityConfigurerAdapter() {

        protected val AUTH_PATH = "/api/v1/auth/**"
        protected val API_PATH_PATTERN = "/api/**"

        @Throws(Exception::class)
        override fun configure(http: HttpSecurity) {
            val tokenAuthenticationFilter =
                    TokenAuthenticationFilter(tokenManager, SkipPathRequestMatcher(listOf(AUTH_PATH)))
            http.csrf().disable().antMatcher(API_PATH_PATTERN)
                    .sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS)
                    .and().authorizeRequests()
                    .antMatchers(AUTH_PATH).permitAll()
                    .antMatchers(API_PATH_PATTERN).authenticated()
                    .and().exceptionHandling().authenticationEntryPoint(CustomAuthenticationEntryPoint())
                    .and().addFilterBefore(tokenAuthenticationFilter, UsernamePasswordAuthenticationFilter::class.java)
        }

        override fun configure(auth: AuthenticationManagerBuilder) {
            auth.authenticationProvider(TokenAuthenticationProvider(userService))
        }

        inner class CustomAuthenticationEntryPoint : AuthenticationEntryPoint {
            private val mapper = ObjectMapper()

            @Throws(IOException::class, ServletException::class)
            override fun commence(req: HttpServletRequest,
                                  res: HttpServletResponse,
                                  authException: AuthenticationException) {
                res.contentType = "application/json;charset=UTF-8"
                res.status = 401
                res.writer.write(mapper.writeValueAsString(mapOf(Pair("code", 3), Pair("message", "Unauthorised"))))
                res.writer.flush()
            }
        }
    }

    @Configuration
    @Order(2)
    open class FilesWebSecurityConfigurerAdapter(override val tokenManager: TokenManager, override val userService: UserService) :
            ApiWebSecurityConfigurerAdapter(tokenManager, userService) {

        private val API_FILES_PATTERN = "/files/**"

        @Throws(Exception::class)
        override fun configure(http: HttpSecurity) {
            val tokenAuthenticationFilter =
                    TokenAuthenticationFilter(tokenManager, SkipPathRequestMatcher(listOf(AUTH_PATH)))
            http.csrf().disable().antMatcher(API_FILES_PATTERN)
                    .sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS)
                    .and().authorizeRequests()
                    .antMatchers(API_FILES_PATTERN).authenticated()
                    .and().exceptionHandling().authenticationEntryPoint(CustomAuthenticationEntryPoint())
                    .and().addFilterBefore(tokenAuthenticationFilter, UsernamePasswordAuthenticationFilter::class.java)
        }
    }

    @Configuration
    open class FormLoginWebSecurityConfigurerAdapter(private val passwordEncoder : PasswordEncoder, private val userService: UserService) : WebSecurityConfigurerAdapter() {

        override fun userDetailsService(): UserDetailsService {
            return userService
        }

        @Throws(java.lang.Exception::class)
        override fun configure(auth: AuthenticationManagerBuilder) {
            auth.userDetailsService(userDetailsService()).passwordEncoder(passwordEncoder);
        }

        @Throws(java.lang.Exception::class)
        override fun configure(http: HttpSecurity) {
            http
                    .csrf().disable()
                    .authorizeRequests()
                    .antMatchers("/login*").permitAll()
                    .anyRequest().authenticated()
                    .and()
                    .formLogin().and().httpBasic()
        }
    }
}

