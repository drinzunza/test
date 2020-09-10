package com.uav_recon.app.api.services

import com.uav_recon.app.api.entities.db.ObservationDefect
import com.uav_recon.app.api.entities.db.Photo
import com.uav_recon.app.api.entities.db.StructuralType
import com.uav_recon.app.api.entities.db.User
import com.uav_recon.app.api.entities.requests.bridge.ObservationDefectDto
import com.uav_recon.app.api.entities.requests.bridge.SimpleUserDto
import com.uav_recon.app.api.entities.requests.bridge.Weather
import com.uav_recon.app.api.repositories.*
import org.slf4j.LoggerFactory
import org.springframework.stereotype.Service
import java.text.SimpleDateFormat
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
            previousDefectNumber = previousDefectNumber
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
            span = span,
            stationMarker = stationMarker,
            observationType = observationType,
            size = size,
            type = type,
            observationNameId = observationNameId,
            clockPosition = clockPosition,
            repairMethod = repairMethod,
            repairDate = repairDate,
            previousDefectNumber = previousDefectNumber
    )

    fun User.toDto(): SimpleUserDto = SimpleUserDto(this)

    @Synchronized
    @Throws(Error::class)
    fun save(dto: ObservationDefectDto,
             inspectionId: String,
             observationId: String,
             updatedBy: Int,
             passedStructureId: String? = null
    ): ObservationDefectDto {
        checkInspectionAndObservationRelationship(inspectionId, observationId)
        var createdBy = updatedBy
        val observationDefect = observationDefectRepository.findById(dto.uuid)
        if (observationDefect.isPresent) {
            createdBy = observationDefect.get().createdBy
        }
        val createdByUser: SimpleUserDto = userService.get(createdBy).toDto()

        try {
            val entity = dto.toEntity(createdBy, updatedBy, observationId)
            val saved = observationDefectRepository.save(entity)
            return saveWeather(saved).toDto(createdByUser)
        } catch (e: Exception) {
            logger.error(e.message)
            // Observation defect id now not unique
            if (dto.id.isBlank()) {
                logger.info("Observation defect id (${dto.id}) incorrect")
                val inspection = inspectionRepository.findFirstByUuidAndDeletedIsFalse(inspectionId)
                val structure = inspection?.structureId?.let { structureRepository.findFirstById(it) }
                dto.id = generateObservationDefectDisplayId(updatedBy.toString(), structure?.code,
                        dto.type == StructuralType.STRUCTURAL
                )
                logger.info("New observation defect id (${dto.id})")

                val entity = dto.toEntity(createdBy, updatedBy, observationId)
                val saved = observationDefectRepository.save(entity)
                return saveWeather(saved).toDto(createdByUser)
            }
        }
        throw Error(242, "Error saving observation defect")
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
}
