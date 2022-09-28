package com.uav_recon.app.api.services

import com.uav_recon.app.api.entities.db.toDto
import com.uav_recon.app.api.entities.requests.bridge.StructureSubdivisionDto
import com.uav_recon.app.api.entities.requests.bridge.toEntity
import com.uav_recon.app.api.repositories.StructureSubdivisionRepository
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional

@Service
class StructureSubdivisionService(
    private val structureSubdivisionRepository: StructureSubdivisionRepository,
    private val observationStructureSubdivisionService: ObservationStructureSubdivisionService
) : BaseService() {

    @Transactional
    fun save(inspectionId: String, dto: StructureSubdivisionDto): StructureSubdivisionDto {
        dto.inspectionId = inspectionId

        val saved = structureSubdivisionRepository.save(dto.toEntity())

        return saved.toDto()
    }

    fun getByUuid(uuid: String): StructureSubdivisionDto? {
        val structureSubdivision = structureSubdivisionRepository.findFirstByUuid(uuid)

        val structureSubdivisionDto = structureSubdivision?.toDto()
        structureSubdivisionDto?.observationStructureSubdivisions = structureSubdivisionDto?.uuid?.let {
            observationStructureSubdivisionService.getAllByStructureSubdivisionId(
                it
            )
        }

        return structureSubdivisionDto
    }

    fun getAllByInspectionId(inspectionId: String): List<StructureSubdivisionDto> {
        val structureSubdivisions = structureSubdivisionRepository.findAllByInspectionId(inspectionId)

        var structureSubdivisionsDto = structureSubdivisions.map { it.toDto() }

        structureSubdivisionsDto.forEach {
            it.observationStructureSubdivisions =
                observationStructureSubdivisionService.getAllByStructureSubdivisionId(it.uuid)
        }

        return structureSubdivisionsDto
    }

    @Throws(Error::class)
    fun delete(uuid: String) {
        val structureSubdivision = structureSubdivisionRepository.findFirstByUuid(uuid)
            ?: throw Error(400, "Specified structure subdivision does not exist")

        return structureSubdivisionRepository.delete(structureSubdivision)
    }
}