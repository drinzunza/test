package com.uav_recon.app.api.services.mapper

import com.uav_recon.app.api.controllers.dto.admin.CreateUserInDTO
import com.uav_recon.app.api.controllers.dto.admin.UpdateUserInDTO
import com.uav_recon.app.api.controllers.dto.admin.UserOutDTO
import com.uav_recon.app.api.entities.db.User
import org.mapstruct.Mapper
import org.mapstruct.MappingTarget
import java.time.OffsetDateTime
import java.time.format.DateTimeFormatter

@Mapper
interface AdminUserMapper {
    fun map(dto: CreateUserInDTO): User
    fun map(user: User): UserOutDTO

    fun map(time: OffsetDateTime?): String? {
        return time?.format(DateTimeFormatter.ISO_INSTANT)
    }

    fun update(carDto: UpdateUserInDTO, @MappingTarget user: User?)
}