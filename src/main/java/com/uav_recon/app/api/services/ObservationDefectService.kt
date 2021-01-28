package com.uav_recon.app.api.services

import com.uav_recon.app.api.entities.db.*
import com.uav_recon.app.api.entities.requests.bridge.ObservationDefectDto
import com.uav_recon.app.api.entities.requests.bridge.SimpleUserDto
import com.uav_recon.app.api.entities.requests.bridge.Weather
import com.uav_recon.app.api.repositories.*
import org.slf4j.LoggerFactory
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional
import java.text.SimpleDateFormat
import java.time.LocalDate
import java.time.OffsetDateTime
import java.time.format.DateTimeFormatter
import java.util.*

@Service
class ObservationDefectService(
        private val observationDefectRepository: ObservationDefectRepository,
        private val observationRepository: ObservationRepository,
        private val inspectionRepository: InspectionRepository,
        private val structureRepository: StructureRepository,
        private val photoRepository: PhotoRepository,
        private val photoService: PhotoService,
        private val weatherService: WeatherService,
        private val userService: UserService
) {

    private val logger = LoggerFactory.getLogger(ObservationDefectService::class.java)

    companion object {
        private const val OBSERVATION_LETTER_STRUCTURAL = "D"
        private const val OBSERVATION_LETTER_MAINTENANCE = "M"
        private const val OBSERVATION_EMPTY_STRUCTURE = "STR"
    }

    private fun ObservationDefect.toDto(createdBy: SimpleUserDto?) = ObservationDefectDto(
            id = id,
            uuid = uuid,
            createdBy = createdBy,
            criticalFindings = criticalFindings?.toList(),
            conditionId = conditionId,
            defectId = defectId,
            description = description,
            materialId = materialId,
            photos = photoService.findAllByObservationDefectIdAndNotDeleted(uuid),
            span = span,
            stationMarker = stationMarker,
            observationType = observationType,
            size = size,
            type = type,
            weather = getWeather(this),
            observationNameId = observationNameId,
            clockPosition = clockPosition,
            repairDate = repairDate,
            repairMethod = repairMethod,
            previousDefectNumber = previousDefectNumber,
            createdAt = createdAt,
            createdAtClient = createdAtClient
    )

    fun ObservationDefectDto.toEntity(
            createdBy: Int, updatedBy: Int, observationId: String, createdAtClient: OffsetDateTime?
    ) = ObservationDefect(
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
            span = span,
            stationMarker = stationMarker,
            observationType = observationType,
            size = size,
            type = type,
            observationNameId = observationNameId,
            clockPosition = clockPosition,
            repairMethod = repairMethod,
            repairDate = repairDate,
            previousDefectNumber = previousDefectNumber,
            createdAtClient = createdAtClient
    )

    fun User.toDto(): SimpleUserDto = SimpleUserDto(this)

    @Throws(Error::class)
    @Transactional
    fun save(dto: ObservationDefectDto,
             inspectionId: String,
             observationId: String,
             updatedBy: Int,
             passedStructureId: String? = null
    ): ObservationDefectDto {
        checkInspectionAndObservationRelationship(inspectionId, observationId)
        val observationDefect = observationDefectRepository.findFirstByUuid(dto.uuid)
        val createdBy = observationDefect?.createdBy ?: updatedBy
        val createdAtClient = observationDefect?.createdAtClient ?: dto.createdAt ?: getDateById(observationDefect?.id)
        val createdByUser: SimpleUserDto = userService.get(createdBy).toDto()

        val entity = dto.toEntity(createdBy, updatedBy, observationId, createdAtClient)
        if (!isCorrectObservationDefectId(dto.id)) {
            logger.info("Incorrect observation defect id ${dto.id} set to ${entity.id}")
            dto.id = entity.id
        }
        if (entity.type != observationDefect?.type) {
            entity.id = changeObservationDefectIdType(entity.id, entity.type)
            logger.info("Changed observation defect id by type ${entity.type}")
        }
        val saved = observationDefectRepository.save(entity)
        return saveWeather(saved).toDto(createdByUser)
    }

    private fun getDateById(observationDefectId: String?): OffsetDateTime? {
        observationDefectId?.let {
            if (it.length > 10
                    && it.substring(it.length - 8, 1) == "-"
                    && it.substring(it.length - 3, 4) > "2015"
                    && it.substring(it.length - 3, 4) < "2050"
                    && it.substring(it.length - 7, 2) > "00"
                    && it.substring(it.length - 7, 2) < "13"
                    && it.substring(it.length - 5, 2) > "00"
                    && it.substring(it.length - 5, 2) < "31"
            ) {
                try {
                    return OffsetDateTime.parse(it.substring(it.length - 7),
                            DateTimeFormatter.ofPattern("MMddyyyy")
                    )
                } catch (e: Exception) {
                    logger.error("Incorrect parse date", e)
                }
            }
        }
        return null
    }

    private fun checkInspectionAndObservationRelationship(inspectionId: String, observationId: String) {
        if (!inspectionRepository.findByUuidAndDeletedIsFalse(inspectionId).isPresent) {
            throw Error(101, "Invalid inspection UUID")
        }
        if (!observationRepository.findByUuidAndInspectionIdAndDeletedIsFalse(observationId, inspectionId).isPresent) {
            throw Error(102, "Invalid observation UUID")
        }
    }

    private fun isCorrectObservationDefectId(id: String): Boolean {
        return id.matches("[\\w\\d_]+-\\w-[\\d]{3}-[\\d]+-[\\d]{8}".toRegex())
    }

    @Throws(Error::class)
    fun update(updatedBy: Int, id: String, observationId: String): ObservationDefectDto {
        val defect = observationDefectRepository.findFirstByUuidAndDeletedIsFalse(id)
        val oldObservation = defect?.observationId?.let { observationRepository.findFirstByUuid(it) }
        val newObservation = observationRepository.findFirstByUuid(observationId)
        if (defect == null) {
            throw Error(103, "Invalid observation defect UUID")
        }
        if (oldObservation == null || newObservation == null) {
            throw Error(102, "Invalid observation UUID")
        }
        if (oldObservation.inspectionId != newObservation.inspectionId) {
            throw Error(105, "Need same inspection")
        }
        val structure = inspectionRepository.findFirstByUuid(newObservation.inspectionId)?.let {
            it.structureId?.let { structureRepository.findFirstById(it) }
        }
        val createdByUser = userService.get(defect.createdBy).toDto()
        defect.observationId = observationId
        defect.updatedBy = updatedBy
        defect.id = changeObservationDefectIdStructure(defect.id, structure)
        return observationDefectRepository.save(defect).toDto(createdByUser)
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

    fun save(list: List<ObservationDefectDto>,
             inspectionId: String,
             observationId: String,
             updatedBy: Int,
             structureId: String?):
            List<ObservationDefectDto> {
        return list.map { dto -> save(dto, inspectionId, observationId, updatedBy, structureId) }
    }

    fun findAllByObservationIdAndNotDeleted(id: String): List<ObservationDefectDto> {
        val ownersMap = mutableMapOf<Int, SimpleUserDto>()
        return observationDefectRepository.findAllByObservationIdAndDeletedIsFalse(id)
                .map { o ->
                    var createdBy = ownersMap[o.createdBy]
                    if (createdBy == null) {
                        createdBy = userService.get(o.createdBy).toDto()
                        ownersMap[o.createdBy] = createdBy
                    }
                    o.toDto(createdBy)
                }
    }

    fun changeObservationDefectIdType(id: String, type: StructuralType?): String {
        val letter = when (type) {
            StructuralType.STRUCTURAL -> OBSERVATION_LETTER_STRUCTURAL
            else -> OBSERVATION_LETTER_MAINTENANCE
        }
        return id.replace("-[DM]-".toRegex(), "-$letter-")
    }

    fun changeObservationDefectIdStructure(id: String, structure: Structure?): String {
        val code = (structure?.code ?: OBSERVATION_EMPTY_STRUCTURE).replace(" ", "_")
        val oldCode = id.replace("-\\w-[\\d]{3}-[\\d]+-[\\d]{8}".toRegex(), "")
        return id.replace(oldCode, code)
    }

    @Throws(Error::class)
    fun generateObservationDefectDisplayId(inspectorId: String, structureCode: String?, structuralObservation: Boolean?): String {
        val date = SimpleDateFormat("MMddyyyy", Locale.US).format(Date())
        val observationLetter = if (structuralObservation != null && structuralObservation)
            OBSERVATION_LETTER_STRUCTURAL else OBSERVATION_LETTER_MAINTENANCE

        val structure = (structureCode ?: OBSERVATION_EMPTY_STRUCTURE).replace(" ", "_")
        val displayIdRegexp = "$structure-$observationLetter-%-$inspectorId-$date"

        val observationDefects = observationDefectRepository.findAllByIdLike(displayIdRegexp)
        observationDefects.forEach {
            logger.info("Exist ${it.id} - ${it.uuid}")
        }
        for (i in 1..5000) {
            val autoNum = String.format("%03d", i)
            val displayId = displayIdRegexp.replace("-%-", "-$autoNum-")
            if (observationDefects.none { it.id == displayId }) {
                return displayId
            }
        }

        throw Error(245, "Cannot create unique observation defect id")
    }

    fun getPhotoWithCoordinates(observationDefect: ObservationDefect?): Photo? {
        if (observationDefect != null) {
            photoRepository.findAllByObservationDefectIdAndDeletedIsFalse(observationDefect.uuid).forEach {
                if (it.latitude != null && it.longitude != null) {
                    return it
                }
            }
        }
        return null
    }

    fun getWeather(observationDefect: ObservationDefect?): Weather? {
        if (observationDefect?.temperature != null) {
            return Weather(observationDefect.temperature, observationDefect.humidity, observationDefect.wind)
        }
        return null
    }

    fun saveWeather(observationDefect: ObservationDefect): ObservationDefect {
        if (observationDefect.temperature == null) {
            val photo = getPhotoWithCoordinates(observationDefect)
            val weather = weatherService.getHistoricalWeather(
                    photo?.latitude, photo?.longitude, photo?.createdAtClient?.toEpochSecond()
            )
            if (weather != null) {
                logger.info("Save defect weather ${photo?.latitude}:${photo?.longitude}, " +
                        "${photo?.createdAtClient}, ${weather.temperature}, ${weather.humidity}, ${weather.wind}")
                observationDefect.temperature = weather.temperature
                observationDefect.humidity = weather.humidity
                observationDefect.wind = weather.wind
                return observationDefectRepository.save(observationDefect)
            }
        } else {
            logger.info("Defect weather already set")
        }
        return observationDefect
    }

    fun regenerateIdsByCode(structureId: String, code: String) {
        val defects = observationDefectRepository.getByStructureId(structureId)
        defects.forEach {
            val oldStructureId = it.id.replace("-\\w-[\\d]{3}-[\\d]+-[\\d]{8}".toRegex(), "")
            val newId = it.id.replace(oldStructureId, code)
            it.id = newId
        }
        observationDefectRepository.saveAll(defects)
    }
}
