package com.uav_recon.app.api.controllers

import com.uav_recon.app.api.controllers.dto.admin.CreateUserInDTO
import com.uav_recon.app.api.controllers.dto.admin.CreateUserOutDTO
import com.uav_recon.app.api.controllers.mapper.AdminUserMapper
import com.uav_recon.app.api.services.UserService
import com.uav_recon.app.configurations.ControllerConfiguration.VERSION
import com.uav_recon.app.configurations.TokenManager
import com.uav_recon.app.configurations.UavConfiguration
import org.mapstruct.factory.Mappers
import org.slf4j.LoggerFactory
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RestController

@RestController
class AdminUserController(private val userService: UserService,
                          private val tokenManager: TokenManager,
                          private val configuration: UavConfiguration) : BaseController() {

    private val logger = LoggerFactory.getLogger(AdminUserController::class.java)
    private val resetPasswordTimeout = configuration.security.resetPasswordTimeout.toLong()
    private val adminUserMapper = Mappers.getMapper(AdminUserMapper::class.java)

    @PostMapping("$VERSION/admin/users")
    fun createUser(@RequestBody request: CreateUserInDTO): ResponseEntity<CreateUserOutDTO> {
        val user = userService.register(adminUserMapper.map(request))
        return ResponseEntity.ok(adminUserMapper.map(user))
    }
}
