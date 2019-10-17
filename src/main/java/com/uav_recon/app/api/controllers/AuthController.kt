package com.uav_recon.app.api.controllers

import com.uav_recon.app.api.entities.responses.Response
import com.uav_recon.app.api.entities.requests.auth.AuthorizationRequest
import com.uav_recon.app.api.entities.requests.auth.RegistrationRequest
import com.uav_recon.app.api.entities.requests.auth.VerificationCode
import com.uav_recon.app.api.entities.responses.auth.RegSession
import com.uav_recon.app.api.entities.responses.auth.UserResponse
import com.uav_recon.app.configurations.ControllerConfiguration.APP_SESSION
import com.uav_recon.app.configurations.ControllerConfiguration.REG_SESSION
import com.uav_recon.app.configurations.ControllerConfiguration.VERSION
import org.slf4j.LoggerFactory
import org.springframework.web.bind.annotation.*

@RestController
class AuthController {

    private val logger = LoggerFactory.getLogger(AuthController::class.java)

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