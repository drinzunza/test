package com.uav_recon.app.api.services

import com.uav_recon.app.api.entities.db.User
import com.uav_recon.app.api.entities.requests.bridge.TemplateDto
import com.uav_recon.app.api.repositories.templates.TemplateRepository
import org.springframework.stereotype.Service

@Service
class TemplateService(
        private val templateRepository: TemplateRepository
) {

    fun listNotDeleted(authenticatedUser: User): List<TemplateDto> {
        return listOf()
    }

    fun getNotDeleted(authenticatedUser: User, id: Long): TemplateDto {
        throw Error(161, "Not found")
    }

    fun save(authenticatedUser: User, body: TemplateDto): TemplateDto {
        throw Error(161, "Not found")
    }

    fun delete(authenticatedUser: User, id: Long) {
        val template = templateRepository.findFirstById(id) ?: throw Error(161, "Not found")
        template.deleted = true
        templateRepository.save(template)
    }
}