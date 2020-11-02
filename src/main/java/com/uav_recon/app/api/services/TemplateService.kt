package com.uav_recon.app.api.services

import com.uav_recon.app.api.entities.db.User
import com.uav_recon.app.api.entities.requests.bridge.TemplateDto
import org.springframework.stereotype.Service

@Service
class TemplateService {

    fun listNotDeleted(authenticatedUser: User): List<TemplateDto> {
        return listOf()
    }

    fun getNotDeleted(authenticatedUser: User, id: Long): TemplateDto {
        throw Error(161, "Not found")
    }

    fun delete(authenticatedUser: User, id: Long) {

    }

    fun save(authenticatedUser: User, body: TemplateDto): TemplateDto {
        throw Error(161, "Not found")
    }
}