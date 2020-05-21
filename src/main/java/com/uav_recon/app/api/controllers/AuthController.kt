package com.uav_recon.app.api.controllers

import com.google.common.collect.ImmutableMap
import com.uav_recon.app.api.entities.db.Company
import com.uav_recon.app.api.entities.db.User
import com.uav_recon.app.api.entities.requests.auth.AuthorizationRequest
import com.uav_recon.app.api.entities.requests.auth.PasswordResetAttemptRequest
import com.uav_recon.app.api.entities.requests.auth.RegistrationRequest
import com.uav_recon.app.api.entities.requests.bridge.CompanyDto
import com.uav_recon.app.api.entities.responses.auth.Inspector
import com.uav_recon.app.api.entities.responses.auth.UserResponse
import com.uav_recon.app.api.repositories.CompanyRepository
import com.uav_recon.app.api.services.UserService
import com.uav_recon.app.configurations.ControllerConfiguration.VERSION
import com.uav_recon.app.configurations.TokenManager
import com.uav_recon.app.configurations.UavConfiguration
import org.slf4j.LoggerFactory
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RestController

@RestController
class AuthController(
        private val userService: UserService,
        private val tokenManager: TokenManager,
        private val configuration: UavConfiguration,
        private val companyRepository: CompanyRepository
) : BaseController() {

    private val logger = LoggerFactory.getLogger(AuthController::class.java)
    private val resetPasswordTimeout = configuration.security.resetPasswordTimeout.toLong()

    fun User.toInspector() = Inspector(
            id = id.toString(),
            email = email,
            firstName = firstName,
            lastName = lastName,
            position = position,
            company = companyId?.let { companyRepository.findFirstById(it)?.toDto() },
            admin = admin
    )

    fun RegistrationRequest.toUser() = User(
            email = email,
            firstName = firstName,
            lastName = lastName,
            position = position,
            password = password
    )

    fun Company.toDto() = CompanyDto(
            id = id,
            name = name,
            logo = logo,
            type = type
    )

    @PostMapping("$VERSION/auth")
    fun auth(@RequestBody request: AuthorizationRequest?): ResponseEntity<UserResponse> {
        val user = userService.authenticate(request?.email, request?.password)
        logger.info("Auth user ${user.id}, ${user.firstName} ${user.lastName}")
        return ResponseEntity.ok(UserResponse(tokenManager.generate(user.id), user.toInspector()))
    }

    @PostMapping("$VERSION/auth/register")
    fun register(@RequestBody request: RegistrationRequest?): ResponseEntity<UserResponse> {
        val user = userService.register(request?.toUser())
        logger.info("Register user ${user.id}, ${user.firstName} ${user.lastName}")
        return ResponseEntity.ok(UserResponse(tokenManager.generate(user.id), user.toInspector()))
    }

    @PostMapping("$VERSION/auth/forgot_password")
    fun forgotPassword(@RequestBody request: PasswordResetAttemptRequest?): ResponseEntity<*> {
        val timeout = userService.passwordResetAttempt(request?.email)
        return if (timeout == resetPasswordTimeout) {
            ResponseEntity.ok(success)
        } else {
            ResponseEntity.ok(ImmutableMap.of("success", false, "timeout", timeout))
        }
    }

    @PostMapping("$VERSION/auth/forgot_password/reset")
    fun resetPassword(@RequestBody request: PasswordResetAttemptRequest): ResponseEntity<*> {
        userService.resetPassword(request.email, request.code, request.password)
        return ResponseEntity.ok(success)
    }
}
