package com.uav_recon.app.api.services

import com.uav_recon.app.api.controllers.handlers.AccessDeniedException
import com.uav_recon.app.api.entities.db.User
import com.uav_recon.app.api.entities.db.toDto
import com.uav_recon.app.api.entities.requests.bridge.StructureSubdivisionDto
import com.uav_recon.app.api.entities.requests.bridge.toEntity
import com.uav_recon.app.api.repositories.InspectionRepository
import com.uav_recon.app.api.repositories.StructureSubdivisionRepository
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional

@Service
class StructureSubdivisionService(
    private val structureSubdivisionRepository: StructureSubdivisionRepository
) : BaseService() {

    @Transactional
    fun save(inspectionId: String, dto: StructureSubdivisionDto): StructureSubdivisionDto {
        dto.inspectionId = inspectionId

        val saved = structureSubdivisionRepository.save(dto.toEntity())

        return saved.toDto()
    }

    fun getByUuid(uuid: String): StructureSubdivisionDto? {
        val structureSubdivision = structureSubdivisionRepository.findFirstByUuid(uuid)

        return structureSubdivision?.toDto()
    }

    fun getAllByInspectionId(inspectionId: String): List<StructureSubdivisionDto> {
        val structureSubdivisions = structureSubdivisionRepository.findAllByInspectionId(inspectionId)

        return structureSubdivisions.map { it.toDto() }
    }

    fun delete(uuid: String) {
        val structureSubdivision = structureSubdivisionRepository.findFirstByUuid(uuid)
            ?: throw Error("Specified structure subdivision does not exist")

        return structureSubdivisionRepository.delete(structureSubdivision)
    }
}