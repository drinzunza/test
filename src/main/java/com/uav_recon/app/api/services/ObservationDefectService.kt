package com.uav_recon.app.api.services

import com.uav_recon.app.api.entities.db.ObservationDefect
import com.uav_recon.app.api.entities.requests.bridge.ObservationDefectDto
import com.uav_recon.app.api.repositories.ObservationDefectRepository
import org.springframework.stereotype.Service
import javax.transaction.Transactional

@Service
class ObservationDefectService(private val observationDefectRepository: ObservationDefectRepository,
                               private val photoService: PhotoService) {

    private fun ObservationDefect.toDto() = ObservationDefectDto(
        id = id,
        uuid = uuid,
        criticalFindings = criticalFindings?.toList(),
        conditionId = conditionId,
        defectId = defectId,
        description = description,
        materialId = materialId,
        photos = photoService.findAllByObservationDejectId(uuid)
    )

    fun ObservationDefectDto.toEntity(createdBy: Int, updatedBy: Int, observationId: String) = ObservationDefect(
        id = id,
        uuid = uuid,
        createdBy = createdBy,
        updatedBy = updatedBy,
        materialId = materialId,
        description = description,
        defectId = defectId,
        conditionId = conditionId,
        criticalFindings = criticalFindings?.toTypedArray(),
        observationId = observationId
    )

    @Transactional
    fun save(dto: ObservationDefectDto, observationId: String, updatedBy: Int): ObservationDefectDto {
        var createdBy = updatedBy
        val observationDefect = observationDefectRepository.findById(dto.uuid)
        if (observationDefect.isPresent) {
            createdBy = observationDefect.get().createdBy
        }
        return observationDefectRepository.save(dto.toEntity(createdBy, updatedBy, observationId)).toDto()
    }

    @Transactional
    fun save(list: List<ObservationDefectDto>, observationId: String, updatedBy: Int): List<ObservationDefectDto> {
        return list.map { dto -> save(dto, observationId, updatedBy) }
    }

    fun findAllByObservationId(id: String): List<ObservationDefectDto> {
        return observationDefectRepository.findAllByObservationId(id).map { o -> o.toDto() }
    }

}
