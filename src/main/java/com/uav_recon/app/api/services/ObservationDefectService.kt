package com.uav_recon.app.api.services

import com.uav_recon.app.api.entities.db.ObservationDefect
import com.uav_recon.app.api.entities.requests.bridge.ObservationDefectDto
import com.uav_recon.app.api.repositories.InspectionRepository
import com.uav_recon.app.api.repositories.ObservationDefectRepository
import com.uav_recon.app.api.repositories.ObservationRepository
import org.springframework.stereotype.Service
import javax.transaction.Transactional

@Service
class ObservationDefectService(private val observationDefectRepository: ObservationDefectRepository,
                               private val observationRepository: ObservationRepository,
                               private val inspectionRepository: InspectionRepository,
                               private val photoService: PhotoService) {

    private fun ObservationDefect.toDto() = ObservationDefectDto(
        id = id,
        uuid = uuid,
        criticalFindings = criticalFindings?.toList(),
        conditionId = conditionId,
        defectId = defectId,
        description = description,
        materialId = materialId,
        photos = photoService.findAllByObservationDefectIdAndNotDeleted(uuid),
        spanNumber = spanNumber
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
        observationId = observationId,
        spanNumber = spanNumber
    )

    @Throws(Error::class)
    @Transactional
    fun save(dto: ObservationDefectDto,
             inspectionId: String,
             observationId: String,
             updatedBy: Int): ObservationDefectDto {
        checkInspectionAndObservationRelationship(inspectionId, observationId)
        var createdBy = updatedBy
        val observationDefect = observationDefectRepository.findById(dto.uuid)
        if (observationDefect.isPresent) {
            createdBy = observationDefect.get().createdBy
        }
        return observationDefectRepository.save(dto.toEntity(createdBy, updatedBy, observationId)).toDto()
    }

    private fun checkInspectionAndObservationRelationship(inspectionId: String, observationId: String) {
        if (!inspectionRepository.findByUuidAndDeletedIsFalse(inspectionId).isPresent) {
            throw Error(101, "Invalid inspection UUID")
        }
        if (!observationRepository.findByUuidAndInspectionIdAndDeletedIsFalse(observationId, inspectionId).isPresent) {
            throw Error(102, "Invalid observation UUID")
        }
    }

    fun delete(id: String, inspectionId: String, observationId: String) {
        checkInspectionAndObservationRelationship(inspectionId, observationId)
        val optional = observationDefectRepository.findById(id)
        if (!optional.isPresent || optional.get().observationId != observationId) {
            throw Error(103, "Invalid observation defect UUID")
        }
        val defect = optional.get()
        defect.deleted = true
        observationDefectRepository.save(defect);
    }

    @Transactional
    fun save(list: List<ObservationDefectDto>, inspectionId: String, observationId: String, updatedBy: Int):
            List<ObservationDefectDto> {
        return list.map { dto -> save(dto, inspectionId, observationId, updatedBy) }
    }

    fun findAllByObservationIdAndNotDeleted(id: String): List<ObservationDefectDto> {
        return observationDefectRepository.findAllByObservationIdAndDeletedIsFalse(id).map { o -> o.toDto() }
    }

}
