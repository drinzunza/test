package com.uav_recon.app.api.controllers

import com.uav_recon.app.api.controllers.dto.admin.CreateUserInDTO
import com.uav_recon.app.api.controllers.dto.admin.UpdateUserInDTO
import com.uav_recon.app.api.controllers.dto.admin.UserOutDTO
import com.uav_recon.app.api.entities.db.User
import com.uav_recon.app.api.services.Error
import com.uav_recon.app.api.services.UserService
import com.uav_recon.app.api.services.mapper.AdminUserMapper
import com.uav_recon.app.configurations.ControllerConfiguration.VERSION
import com.uav_recon.app.configurations.ControllerConfiguration.X_TOKEN
import com.uav_recon.app.configurations.TokenManager
import com.uav_recon.app.configurations.UavConfiguration
import org.mapstruct.factory.Mappers
import org.slf4j.LoggerFactory
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*
import java.util.*
import java.util.stream.Collectors

@RestController
@RequestMapping("$VERSION/admin/users")
class AdminUserController(private val userService: UserService,
                          private val tokenManager: TokenManager,
                          private val configuration: UavConfiguration) : BaseController() {

    private val logger = LoggerFactory.getLogger(AdminUserController::class.java)
    private val adminUserMapper = Mappers.getMapper(AdminUserMapper::class.java)

    @PostMapping
    fun createUser(@RequestHeader(X_TOKEN) token: String, @RequestBody request: CreateUserInDTO): ResponseEntity<UserOutDTO> {
        this.checkAdmin()
        val user = userService.createUser(adminUserMapper.map(request), this.getAuthenticatedUser())
        return ResponseEntity.ok(adminUserMapper.map(user))
    }

    @GetMapping("/{userId}")
    fun getUser(@RequestHeader(X_TOKEN) token: String, @PathVariable userId: Long): ResponseEntity<UserOutDTO> {
        this.checkAdmin()
        val user = userService.get(userId)
        if (user.deletedAt == null) {
            throw Error(18, "User not found")
        }
        return ResponseEntity.ok(adminUserMapper.map(user))
    }

    @GetMapping
    fun listUsers(
            @RequestHeader(X_TOKEN) token: String,
            @RequestParam("companyId") companyId: Optional<Long>
    ): ResponseEntity<List<UserOutDTO>> {
        var userCompanyId = this.getAuthenticatedCompanyId() ?: throw Error(19, "You not have a company");
        if (companyId.isPresent()) {
            userCompanyId = companyId.get()
        }

        val users = userService.listByCompanyId(userCompanyId).filter { it.deletedAt == null }
        val usersDto = users.stream().map {user -> adminUserMapper.map(user)}.collect(Collectors.toList());
        return ResponseEntity.ok(usersDto)
    }

    @PutMapping("/{userId}")
    fun updateUser(@RequestHeader(X_TOKEN) token: String, @RequestBody request: UpdateUserInDTO, @PathVariable userId: Long): ResponseEntity<UserOutDTO> {
        this.checkAdmin()
        val user = userService.update(userId, request, this.getAuthenticatedUser())
        return ResponseEntity.ok(adminUserMapper.map(user))
    }

    @DeleteMapping("/{userId}")
    fun deleteUser(@RequestHeader(X_TOKEN) token: String, @PathVariable userId: Long): ResponseEntity<Long> {
        this.checkAdmin()
        val user = userService.delete(userId, this.getAuthenticatedUser())
        return ResponseEntity.ok(userId)
    }
}
