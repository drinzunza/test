package com.uav_recon.app.api.services

import com.uav_recon.app.api.controllers.handlers.ExceptionsHandler
import com.uav_recon.app.api.entities.db.*
import com.uav_recon.app.api.entities.requests.bridge.*
import com.uav_recon.app.api.repositories.InspectionRepository
import com.uav_recon.app.api.repositories.ObservationRepository
import com.uav_recon.app.api.repositories.SubcomponentRepository
import com.uav_recon.app.api.repositories.templates.SubcomponentAndStructureRepository
import com.uav_recon.app.api.utils.isEachMeasureUnit
import com.uav_recon.app.api.utils.round
import org.slf4j.LoggerFactory
import org.springframework.stereotype.Service
import java.util.*
import javax.transaction.Transactional
import kotlin.collections.ArrayList

@Service
class ObservationService(
    private val inspectionRepository: InspectionRepository,
    private val observationRepository: ObservationRepository,
    private val observationDefectService: ObservationDefectService,
    private val subcomponentAndStructureRepository: SubcomponentAndStructureRepository,
    private val subcomponentRepository: SubcomponentRepository
) {
    private val MEASURE_TYPE_EACH = "each"
    private val invalidInspectionUuid = Error(101, "Invalid inspection UUID")
    private val logger = LoggerFactory.getLogger(ExceptionsHandler::class.java)

    fun Observation.toDto() = ObservationDto(
        id = id,
        uuid = uuid,
        drawingNumber = drawingNumber,
        locationDescription = locationDescription,
        roomNumber = roomNumber,
        dimensionNumber = dimensionNumber,
        structuralComponentId = structuralComponentId,
        subComponentId = subComponentId,
        observationDefects = observationDefectService.findAllByObservationIdAndNotDeleted(uuid),
        inspected = inspected,
        healthIndex = healthIndex,
        computedHealthIndex = calculateObservationHealthIndex(this),
        generalSummary = generalSummary,
        useHealthIndex = null
    )

    fun Observation.toDtoV2(observationDefects: List<ObservationDefectDto>) = ObservationDto(
        id = id,
        uuid = uuid,
        drawingNumber = drawingNumber,
        locationDescription = locationDescription,
        roomNumber = roomNumber,
        dimensionNumber = dimensionNumber,
        structuralComponentId = structuralComponentId,
        subComponentId = subComponentId,
        observationDefects = observationDefects.filter { it.observationId == uuid },
        inspected = inspected,
        healthIndex = healthIndex,
        computedHealthIndex = calculateObservationHealthIndex(this),
        generalSummary = generalSummary,
        useHealthIndex = null
    )

    fun ObservationDto.toEntity(createdBy: Int, updatedBy: Int, inspectionId: String, currentHealthIndex: Double?) =
        Observation(
            id = id,
            uuid = uuid,
            createdBy = createdBy,
            updatedBy = updatedBy,
            subComponentId = subComponentId,
            structuralComponentId = structuralComponentId,
            dimensionNumber = dimensionNumber,
            roomNumber = roomNumber,
            locationDescription = locationDescription,
            drawingNumber = drawingNumber,
            inspectionId = inspectionId,
            generalSummary = generalSummary,
            healthIndex = if (useHealthIndex == true) healthIndex else currentHealthIndex
        )

    fun cloneObservation(sourceObservationDto: ObservationDto, createdBy: Int, updatedBy: Int,
                         inspectionId: String): ObservationDto {
        val generatedUuid = UUID.randomUUID().toString()
        val cloneObservation = Observation(
            id = generatedUuid,
            uuid = generatedUuid,
            createdBy = createdBy,
            updatedBy = updatedBy,
            subComponentId = sourceObservationDto.subComponentId,
            structuralComponentId = sourceObservationDto.structuralComponentId,
            dimensionNumber = sourceObservationDto.dimensionNumber,
            roomNumber = sourceObservationDto.roomNumber,
            locationDescription = sourceObservationDto.locationDescription,
            drawingNumber = sourceObservationDto.drawingNumber,
            inspectionId = inspectionId,
            generalSummary = sourceObservationDto.generalSummary,
            healthIndex = sourceObservationDto.healthIndex
        )

        return observationRepository.save(cloneObservation).toDto()
    }

    @Throws(Error::class)
    @Transactional
    fun save(dto: ObservationDto, inspectionId: String, updatedBy: Int): ObservationDto {
        val inspection = inspectionRepository.findFirstByUuidAndDeletedIsFalse(inspectionId)
            ?: throw Error(101, "Invalid inspection UUID")
        val observation = observationRepository.findFirstByUuid(dto.uuid)
        val createdBy = observation?.createdBy ?: updatedBy

        // Disabled set value without useHealthIndex = true. Need to support old app and frontend versions.
        val saved =
            observationRepository.save(dto.toEntity(createdBy, updatedBy, inspectionId, observation?.healthIndex))
        return saved.toDto()
    }

    @Throws(Error::class)
    @Transactional
    fun saveV2(dto: ObservationDto, inspectionId: String, updatedBy: Int): ObservationDto {
        val inspection = inspectionRepository.findFirstByUuidAndDeletedIsFalse(inspectionId)
            ?: throw Error(101, "Invalid inspection UUID")
        val observation = observationRepository.findFirstByUuid(dto.uuid)
        val createdBy = observation?.createdBy ?: updatedBy

        // Disabled set value without useHealthIndex = true. Need to support old app and frontend versions.
        val saved =
            observationRepository.save(dto.toEntity(createdBy, updatedBy, inspectionId, observation?.healthIndex))
        dto.observationDefects?.forEach {
            observationDefectService.save(it, inspectionId, saved.uuid, updatedBy)
        }
        return saved.toDto()
    }

    @Transactional
    fun save(list: List<ObservationDto>, inspectionId: String, updatedBy: Int): List<ObservationDto> {
        return list.map { dto -> save(dto, inspectionId, updatedBy) }
    }

    fun updateInspected(dto: ObservationInspectDto, inspectionId: String, updatedBy: Int): ObservationDto {
        val inspection = inspectionRepository.findFirstByUuid(inspectionId)
            ?: throw Error(101, "Invalid inspection UUID")
        val observation = observationRepository.findFirstByUuid(dto.uuid)
            ?: throw Error(102, "Invalid observation uuid")
        observation.updatedBy = updatedBy
        observation.inspected = dto.inspected
        return observationRepository.save(observation).toDto()
    }

    fun updateObservation(user: User, uuid: String, dto: ObservationUpdateDto): ObservationDto {
        val observation = observationRepository.findFirstByUuid(uuid)
            ?: throw Error(102, "Invalid observation uuid")
        observation.update(dto)
        return observationRepository.save(observation).toDto()
    }

    fun generateObservationsFromTemplate(
        authenticatedUser: User,
        structureId: String,
        inspectionId: String
    ): List<ObservationDto> {
        val observationList = mutableListOf<ObservationDto>()
        val subComponentAndStructureList = subcomponentAndStructureRepository.findAllByStructureId(structureId)
        val subComponents =
            subcomponentRepository.findAllByDeletedIsFalseAndIdIn(subComponentAndStructureList.map { it.subcomponentId })
                .map { it.id to it }.toMap()
        subComponentAndStructureList.forEach {
            if (it.subcomponentId in subComponents) {
                val generatedUUID = UUID.randomUUID().toString()
                observationList.add(
                    Observation(
                        generatedUUID,
                        generatedUUID,
                        authenticatedUser.id.toInt(),
                        authenticatedUser.id.toInt(),
                        inspectionId,
                        subComponents[it.subcomponentId]?.componentId,
                        it.subcomponentId,
                        dimensionNumber = it.size
                    ).toDto()
                )
            }
        }
        return observationList
    }

    fun findAllByInspectionUuidAndNotDeleted(uuid: String): List<ObservationDto> {
        val observationDtos = mutableListOf<ObservationDto>();
        observationRepository.findAllByInspectionIdAndDeletedIsFalse(uuid).parallelStream()
            .forEach { o -> observationDtos.add(o.toDto()) }
        return observationDtos
    }

    fun findAllByInspectionUuidsAndNotDeleted(uuids: List<String>): Map<String, List<ObservationDto>> {
        val observations = observationRepository.findAllByDeletedIsFalseAndInspectionIdIn(uuids)
        val observationDefects = observationDefectService.findAllByObservationIdsAndNotDeleted(observations.map { it.uuid })
        return observations.groupBy ( {it.inspectionId } , { it.toDtoV2(observationDefects) } )
    }

    @Throws(Error::class)
    fun delete(id: String, inspectionId: String) {
        val optional = observationRepository.findByUuidAndDeletedIsFalse(id)
        if (!optional.isPresent) {
            throw Error(102, "Invalid observation uuid")
        }
        val observation = optional.get()
        if (observation.inspectionId != inspectionId) {
            throw invalidInspectionUuid
        }
        observation.deleted = true
        observationRepository.save(observation);
    }

    fun getTotalQuantity(observation: Observation, spansCount: Int): Int {
        return observation.dimensionNumber ?: 0
    }

    fun getCsValue(observation: Observation, conditionType: ConditionType, spansCount: Int): Int {
        return when (conditionType) {
            ConditionType.GOOD -> getTotalQuantity(
                observation,
                spansCount
            ) - ConditionType.LIST_EXCLUDING_GOOD.sumBy { getCsValue(observation, it, spansCount) }
            else -> when {
                observation.subcomponent?.isEachMeasureUnit() ?: false -> calculateCsProcessB(
                    observation,
                    conditionType
                )
                else -> calculateCsProcessA(observation, conditionType)
            }
        }
    }

    fun calculateObservationHealthIndex(observation: Observation): Double? {
        val measureUnit = observation.subcomponent?.measureUnit
        val componentSize = observation.dimensionNumber
        val defects = observation.defects
        val totalDefectSizeQtyCS1: Double
        val totalDefectSizeQtyCS2: Double
        val totalDefectSizeQtyCS3: Double
        val totalDefectSizeQtyCS4: Double
        var subcomponentHI = 0.0
        if (componentSize == null || defects == null || measureUnit == null) {
            return null
        }
        return when {
            // Calculate HI for each sub-component with EA (each)
//            measureUnit.equals("ea", true) -> {
//                val distinctLocations = defects.mapNotNull { it.span }.distinct()
//                distinctLocations.forEach { locationSpan -> run {
//                        val locationDefects = defects.filter { defect -> defect.span == locationSpan }
//                        val locationDefectsConditions = locationDefects.mapNotNull { it.condition?.type }.distinct()
//                        logger.info("locationDefects: $locationDefects")
//                        logger.info("locationDefectsConditions: $locationDefectsConditions")
//                } }
//                logger.info("uuid: ${observation.uuid}")
//                logger.info("distinctLocations: $distinctLocations")
//                logger.info("totalDefectSizeCS2toCS4: $totalDefectSizeCS2toCS4")
//                logger.info("totalDefectSizeQtyCS1: $totalDefectSizeQtyCS1")
//                logger.info("subcomponentHI: $subcomponentHI")
//                return subcomponentHI
//            }
            // Calculate HI for each sub-component with LF & SF
            measureUnit.equals("lf", true) || measureUnit.equals("sf", true) || measureUnit.equals("ea", true) -> {
                val totalDefectSizeCS2toCS4: Double = defects
                    .filter { it.type == StructuralType.STRUCTURAL }
                    .filter { it.condition?.type != ConditionType.GOOD || it.condition?.type != null}
                    .sumByDouble { it.size?.toDoubleOrNull() ?: 0.0 }
                totalDefectSizeQtyCS1 = componentSize - totalDefectSizeCS2toCS4
                totalDefectSizeQtyCS2 = getTotalDefectSizeForCondition(defects, ConditionType.FAIR)
                totalDefectSizeQtyCS3 = getTotalDefectSizeForCondition(defects, ConditionType.POOR)
                totalDefectSizeQtyCS4 = getTotalDefectSizeForCondition(defects, ConditionType.SEVERE)
                subcomponentHI = (totalDefectSizeQtyCS1 + totalDefectSizeQtyCS2 + totalDefectSizeQtyCS3 + totalDefectSizeQtyCS4) / componentSize
                return subcomponentHI
            }
            else -> null
        }
    }

    private fun getTotalDefectSizeForCondition(defects: List<ObservationDefect>, conditionType: ConditionType): Double {
        return defects
            .filter { it.type == StructuralType.STRUCTURAL }
            .filter { it.condition?.type == conditionType }
            .sumByDouble { it.size?.toDoubleOrNull() ?: 0.0 } * conditionType.csWeight
    }

    private fun calculateCsProcessA(observation: Observation, conditionType: ConditionType): Int {
        return observation.defects
            ?.filter { it.type == StructuralType.STRUCTURAL }
            ?.filter { conditionType == it.condition?.type }
            ?.sumBy { it.size?.toIntOrNull() ?: 0 } ?: 0
    }

    private fun calculateCsProcessB(observation: Observation, conditionType: ConditionType): Int {
        return observation.defects
            ?.filter { it.type == StructuralType.STRUCTURAL }
            ?.filter { it.span != null }
            ?.groupBy(ObservationDefect::span)
            ?.mapValues {
                it.value
                    .mapNotNull { type -> type.condition?.type }
                    .max()
            }
            ?.count {
                it.value == conditionType
            } ?: 0
    }

    fun getHealthIndex(observation: Observation, spansCount: Int): Double {
        observation.healthIndex?.let { return it }
        val totalQuantity = getTotalQuantity(observation, spansCount)
        if (totalQuantity <= 0) return 0.0

        return ConditionType.values().sumByDouble {
            getCsValue(observation, it, spansCount) * it.csWeight / totalQuantity
        }
    }

    fun getSpansCount(observation: Observation, spansCount: Int?): Int? {
        return observation.getSpansCountByObservation(spansCount)
    }

    fun Observation.getSpansCountByObservation(spansCount: Int?): Int? {
        return getLocationId()?.getAvailableSpansSize(spansCount)
    }

    private fun Observation.getLocationId(): LocationId? {
        if (structuralComponentId == null && subComponentId == null) return null

        return locationIds?.firstOrNull { locationId ->
            var matches = true
            structuralComponentId?.let { majorId ->
                locationId.majorIds?.let { possibleIds ->
                    matches = matches and possibleIds.contains(majorId)
                }
            }
            subComponentId?.let { subId ->
                locationId.subComponentIds?.let { possibleIds ->
                    matches = matches and possibleIds.contains(subId)
                }
            }
            matches
        }
    }

    private fun LocationId.getAvailableSpans(spanNumber: Int?): List<String> {
        val spans = mutableListOf<String>()
        alwaysShownSpans?.let {
            spans += it
        }
        spanNumber?.let { inspectionSpanNumber ->
            iteratedSpanPatterns?.split(",")?.let { patterns ->
                for (i in 1..inspectionSpanNumber)
                    spans += patterns.map { it.format(i) }
            }
        }
        return spans
    }

    private fun LocationId.getAvailableSpansSize(spanNumber: Int?): Int {
        var result = 0
        alwaysShownSpans?.let {
            result += 1
        }
        spanNumber?.let { inspectionSpanNumber ->
            iteratedSpanPatterns
                ?.count { it == ',' }
                ?.let { size ->
                    result += inspectionSpanNumber * (size + 1)
                }
        }
        return result
    }
}
