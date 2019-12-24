package com.uav_recon.app.api.services

import com.uav_recon.app.api.entities.db.ObservationDefect
import com.uav_recon.app.api.entities.db.StructuralType
import com.uav_recon.app.api.entities.requests.bridge.ObservationDefectDto
import com.uav_recon.app.api.repositories.InspectionRepository
import com.uav_recon.app.api.repositories.ObservationDefectRepository
import com.uav_recon.app.api.repositories.ObservationRepository
import org.slf4j.LoggerFactory
import org.springframework.stereotype.Service
import java.text.SimpleDateFormat
import java.util.*
import javax.transaction.Transactional

@Service
class ObservationDefectService(private val observationDefectRepository: ObservationDefectRepository,
                               private val observationRepository: ObservationRepository,
                               private val inspectionRepository: InspectionRepository,
                               private val photoService: PhotoService) {

    private val logger = LoggerFactory.getLogger(ObservationDefectService::class.java)

    companion object {
        private const val OBSERVATION_LETTER_STRUCTURAL = "D"
        private const val OBSERVATION_LETTER_MAINTENANCE = "M"
        private const val OBSERVATION_EMPTY_STRUCTURE = "STR"
    }

    private fun ObservationDefect.toDto() = ObservationDefectDto(
        id = id,
        uuid = uuid,
        criticalFindings = criticalFindings?.toList(),
        conditionId = conditionId,
        defectId = defectId,
        description = description,
        materialId = materialId,
        photos = photoService.findAllByObservationDefectIdAndNotDeleted(uuid),
        spanNumber = spanNumber,
        span = span,
        stationMarker = stationMarker,
        observationType = observationType,
        size = size,
        type = type
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
        spanNumber = spanNumber,
        span = span,
        stationMarker = stationMarker,
        observationType = observationType,
        size = size,
        type = type
    )

    @Synchronized
    @Throws(Error::class)
    @Transactional
    fun save(dto: ObservationDefectDto,
             inspectionId: String,
             observationId: String,
             updatedBy: Int,
             passedStructureId: String? = null): ObservationDefectDto {
        var structureId = passedStructureId
        checkInspectionAndObservationRelationship(inspectionId, observationId)
        var createdBy = updatedBy
        val observationDefect = observationDefectRepository.findById(dto.uuid)
        if (observationDefect.isPresent) {
            createdBy = observationDefect.get().createdBy
        }
        if (structureId.isNullOrEmpty()) {
            structureId = inspectionRepository.findByUuidAndDeletedIsFalse(inspectionId).get().structureId
        }
        if (dto.id.isBlank() || observationDefectRepository.countById(dto.id) > 0) {
            logger.info("Observation defect id (${dto.id}) incorrect")
            dto.id = generateObservationDefectDisplayId(updatedBy.toString(), structureId,
                    dto.type == StructuralType.STRUCTURAL
            )
            logger.info("New observation defect id (${dto.id})")
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

    @Throws(Error::class)
    fun delete(id: String, inspectionId: String, observationId: String) {
        checkInspectionAndObservationRelationship(inspectionId, observationId)
        val optional = observationDefectRepository.findByUuidAndDeletedIsFalse(id)
        if (!optional.isPresent || optional.get().observationId != observationId) {
            throw Error(103, "Invalid observation defect UUID")
        }
        val defect = optional.get()
        defect.deleted = true
        observationDefectRepository.save(defect);
    }

    @Transactional
    fun save(list: List<ObservationDefectDto>,
             inspectionId: String,
             observationId: String,
             updatedBy: Int,
             structureId: String?):
            List<ObservationDefectDto> {
        return list.map { dto -> save(dto, inspectionId, observationId, updatedBy, structureId) }
    }

    fun findAllByObservationIdAndNotDeleted(id: String): List<ObservationDefectDto> {
        return observationDefectRepository.findAllByObservationIdAndDeletedIsFalse(id).map { o -> o.toDto() }
    }

    @Throws(Error::class)
    fun generateObservationDefectDisplayId(inspectorId: String, structureId: String?,
                                           structuralObservation: Boolean?
    ): String {
        val date = SimpleDateFormat("MMddyyyy", Locale.US).format(Date())
        val observationLetter = structuralObservation?.let {
            if (structuralObservation) OBSERVATION_LETTER_STRUCTURAL else OBSERVATION_LETTER_MAINTENANCE
        }

        val displayIdRegexp = "${structureId ?: OBSERVATION_EMPTY_STRUCTURE}-$observationLetter-%-$inspectorId-$date"

        val observationDefects = observationDefectRepository.findAllByIdLike(displayIdRegexp)
        for (i in 1..1000) {
            val autoNum = String.format("%03d", i)
            val displayId = displayIdRegexp.replace("-%-", "-$autoNum-")
            if (observationDefects.filter { it.id == displayId }.isEmpty()) {
                return displayId
            }
        }

        throw Error(245, "Cannot create unique observation defect id")
    }
}
