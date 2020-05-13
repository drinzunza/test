package com.uav_recon.app.api.controllers.mapper

import com.uav_recon.app.api.controllers.dto.admin.CreateUserInDTO
import com.uav_recon.app.api.controllers.dto.admin.CreateUserOutDTO
import com.uav_recon.app.api.entities.db.User
import org.mapstruct.Mapper

@Mapper
interface AdminUserMapper {
    fun map(dto: CreateUserInDTO): User
    fun map(user: User): CreateUserOutDTO
}