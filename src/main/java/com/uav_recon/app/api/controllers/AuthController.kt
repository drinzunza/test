package com.uav_recon.app.api.controllers

import com.uav_recon.app.api.entities.db.User
import com.uav_recon.app.api.entities.requests.auth.AuthorizationRequest
import com.uav_recon.app.api.entities.requests.auth.PasswordResetAttemptRequest
import com.uav_recon.app.api.entities.requests.auth.RegistrationRequest
import com.uav_recon.app.api.entities.requests.auth.VerificationCode
import com.uav_recon.app.api.entities.responses.Response
import com.uav_recon.app.api.entities.responses.auth.Inspector
import com.uav_recon.app.api.entities.responses.auth.RegSession
import com.uav_recon.app.api.entities.responses.auth.UserResponse
import com.uav_recon.app.api.services.UserService
import com.uav_recon.app.configurations.ControllerConfiguration.APP_SESSION
import com.uav_recon.app.configurations.ControllerConfiguration.REG_SESSION
import com.uav_recon.app.configurations.ControllerConfiguration.VERSION
import com.uav_recon.app.configurations.TokenManager
import org.slf4j.LoggerFactory
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*
import java.util.*

@RestController
class AuthController(val userService: UserService, val tokenManager: TokenManager) {

    private val logger = LoggerFactory.getLogger(AuthController::class.java)
    private val success = Collections.singletonMap("success", true)

    fun User.toInspector() = Inspector(
            id = id!!.toString(),
            email = email,
            firstName = firstName,
            lastName = lastName,
            position = position
    )

    fun RegistrationRequest.toUser() = User(
            email = email,
            firstName = firstName,
            lastName = lastName,
            position = position,
            password = password
    )

    @PostMapping("$VERSION/auth")
    fun auth(@RequestBody request: AuthorizationRequest?): ResponseEntity<*> {
        val user: User = userService.authenticate(request?.email, request?.password)
        return ResponseEntity.ok(UserResponse(tokenManager.generate(user.id!!), user.toInspector()))
    }

    @PostMapping("$VERSION/auth/register")
    fun register(@RequestBody request: RegistrationRequest?): ResponseEntity<UserResponse> {
        val user = userService.register(request?.toUser())
        return ResponseEntity.ok(UserResponse(tokenManager.generate(user.id!!), user.toInspector()))
    }

    @PostMapping("$VERSION/auth/forgot_password")
    fun forgotPassword(@RequestBody request: PasswordResetAttemptRequest?): ResponseEntity<*> {
        userService.passwordResetAttempt(request?.email)
        return ResponseEntity.ok(success)
    }

    @PostMapping("$VERSION/auth/forgot_password/reset")
    fun resetPassword(@RequestBody request: PasswordResetAttemptRequest): ResponseEntity<*> {
        userService.resetPassword(request.email, request.code, request.password)
        return ResponseEntity.ok(success)
    }

    @PostMapping("$VERSION/authorization")
    fun authorization(@RequestBody request: AuthorizationRequest): Response<UserResponse> {
        return Response()
    }

    @PostMapping("$VERSION/registration")
    fun registration(@RequestBody request: RegistrationRequest): Response<RegSession> {
        return Response()
    }

    @PostMapping("$VERSION/registration/confirm")
    fun confirm(@RequestBody request: VerificationCode,
                @RequestHeader(REG_SESSION) session: String): Response<UserResponse> {
        return Response()
    }

    @GetMapping("$VERSION/registration/notReceived")
    fun confirmAgain(@RequestHeader(REG_SESSION) session: String): Response<RegSession> {
        return Response()
    }

    @GetMapping("$VERSION/authentication")
    fun authentication(@RequestHeader(APP_SESSION) appSession: String): Response<UserResponse> {
        return Response()
    }

    @DeleteMapping("$VERSION/authentication/logout")
    fun logout(@RequestHeader(APP_SESSION) appSession: String): Response<Unit> {
        return Response()
    }
}
