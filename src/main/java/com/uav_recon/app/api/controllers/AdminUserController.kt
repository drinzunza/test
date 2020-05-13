package com.uav_recon.app.api.controllers

import com.uav_recon.app.api.controllers.dto.admin.CreateUserInDTO
import com.uav_recon.app.api.controllers.dto.admin.UpdateUserInDTO
import com.uav_recon.app.api.controllers.dto.admin.UserOutDTO
import com.uav_recon.app.api.entities.db.User
import com.uav_recon.app.api.services.mapper.AdminUserMapper
import com.uav_recon.app.api.services.UserService
import com.uav_recon.app.configurations.ControllerConfiguration
import com.uav_recon.app.configurations.ControllerConfiguration.VERSION
import com.uav_recon.app.configurations.TokenManager
import com.uav_recon.app.configurations.UavConfiguration
import org.mapstruct.factory.Mappers
import org.slf4j.LoggerFactory
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*
import java.util.stream.Collectors

@RestController
@RequestMapping("$VERSION/admin/users")
class AdminUserController(private val userService: UserService,
                          private val tokenManager: TokenManager,
                          private val configuration: UavConfiguration) : BaseController() {

    private val logger = LoggerFactory.getLogger(AdminUserController::class.java)
    private val adminUserMapper = Mappers.getMapper(AdminUserMapper::class.java)

    @PostMapping
    fun createUser(@RequestHeader(ControllerConfiguration.X_TOKEN) token: String, @RequestBody request: CreateUserInDTO): ResponseEntity<UserOutDTO> {
        val user = userService.register(adminUserMapper.map(request))
        return ResponseEntity.ok(adminUserMapper.map(user))
    }

    @GetMapping("/{userId}")
    fun getUser(@RequestHeader(ControllerConfiguration.X_TOKEN) token: String, @PathVariable userId: Long): ResponseEntity<UserOutDTO> {
        val user: User = userService.get(userId)
        return ResponseEntity.ok(adminUserMapper.map(user))
    }

    @GetMapping
    fun listUsers(@RequestHeader(ControllerConfiguration.X_TOKEN) token: String): ResponseEntity<List<UserOutDTO>> {
        val users: List<User> = userService.list()
        val usersDto: List<UserOutDTO> = users.stream().map {user -> adminUserMapper.map(user)}.collect(Collectors.toList());
        return ResponseEntity.ok(usersDto)
    }

    @PutMapping("/{userId}")
    fun updateUser(@RequestHeader(ControllerConfiguration.X_TOKEN) token: String, @RequestBody request: UpdateUserInDTO, @PathVariable userId: Long): ResponseEntity<UserOutDTO> {
        val user = userService.update(userId, request)
        return ResponseEntity.ok(adminUserMapper.map(user))
    }

    @DeleteMapping("/{userId}")
    fun deleteUser(@RequestHeader(ControllerConfiguration.X_TOKEN) token: String, @PathVariable userId: Long): ResponseEntity<Long> {
        val user = userService.delete(userId)
        return ResponseEntity.ok(userId)
    }
}
