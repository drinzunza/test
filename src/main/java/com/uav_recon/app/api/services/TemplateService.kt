package com.uav_recon.app.api.services

import com.uav_recon.app.api.controllers.handlers.AccessDeniedException
import com.uav_recon.app.api.entities.db.User
import com.uav_recon.app.api.entities.db.templates.SubcomponentAndStructure
import com.uav_recon.app.api.entities.db.templates.SubcomponentInspection
import com.uav_recon.app.api.entities.requests.bridge.templates.SubcomponentAndStructuresDto
import com.uav_recon.app.api.entities.requests.bridge.templates.SubcomponentInspectionDto
import com.uav_recon.app.api.repositories.templates.SubcomponentAndStructureRepository
import com.uav_recon.app.api.repositories.templates.SubcomponentInspectionRepository
import org.springframework.stereotype.Service
import javax.transaction.Transactional

@Service
class TemplateService(
        private val subcomponentAndStructureRepository: SubcomponentAndStructureRepository,
        private val subcomponentInspectionRepository: SubcomponentInspectionRepository
) {

    fun getSubcomponentAndStructures(authenticatedUser: User, structureId: String): List<SubcomponentAndStructure> {
        return subcomponentAndStructureRepository.findAllByStructureId(structureId)
    }

    @Transactional
    fun saveSubcomponentAndStructures(authenticatedUser: User, body: SubcomponentAndStructuresDto) {
        if (!authenticatedUser.admin) throw AccessDeniedException()
        val structureIds = body.subcomponentAndStructures.map { it.structureId }
        subcomponentAndStructureRepository.deleteByStructureIdIn(structureIds)
        subcomponentAndStructureRepository.saveAll(body.subcomponentAndStructures)
    }

    fun getSubcomponentInspection(authenticatedUser: User, inspectionId: String): List<SubcomponentInspection> {
        return subcomponentInspectionRepository.findAllByInspectionId(inspectionId)
    }

    @Transactional
    fun saveSubcomponentInspection(authenticatedUser: User, body: SubcomponentInspectionDto) {
        if (!authenticatedUser.admin) throw AccessDeniedException()
        val inspectionIds = body.subcomponentInspections.map { it.inspectionId }
        subcomponentInspectionRepository.deleteByInspectionIdIn(inspectionIds)
        subcomponentInspectionRepository.saveAll(body.subcomponentInspections)
    }
}