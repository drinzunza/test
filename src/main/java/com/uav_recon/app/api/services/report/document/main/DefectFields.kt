package com.uav_recon.app.api.services.report.document.main

import com.uav_recon.app.api.entities.db.*
import com.uav_recon.app.api.repositories.ObservationDefectRepository
import com.uav_recon.app.api.repositories.PhotoRepository
import com.uav_recon.app.api.services.report.document.main.MainDocumentFactory.Companion.DATE_FORMAT
import com.uav_recon.app.api.services.report.document.models.body.Alignment
import com.uav_recon.app.api.utils.formatDate
import com.uav_recon.app.api.utils.normalName
import java.text.DateFormat
import java.text.SimpleDateFormat
import java.time.OffsetDateTime
import java.util.*

internal enum class DefectFields(val title: String) {

    OBSERVATION_ID("Observation Id: "),
    COMPONENT("Component: "),
    SPAN("Span #: "),
    SUB_COMPONENT("Sub-component name: "),
    DRAWING_NUMBER("Drawing Number: "),
    LOCATION("Location: "),
    ROOM_NO("Room No.: "),
    DEFECT("Defect ID: "),
    DEFECT_NUMBER("Defect Number: "),
    DEFECT_NAME("Defect Name: "),
    DEFECT_CONDITION("Defect Condition State: "),
    INSPECTION_DATE("Inspection date: "),
    STATIONING("Stationing: "),
    CRITICAL_FINDINGS("Critical Findings: "),
    PHOTO_QTY("Photo QTY's: ");

    fun getValue(inspection: Inspection, structure: Structure?,
                 observation: Observation, defect: ObservationDefect,
                 observationDefectRepository: ObservationDefectRepository,
                 photoRepository: PhotoRepository
    ): String? {
        return when (this) {
            OBSERVATION_ID -> observation.id
            COMPONENT -> observation.structuralComponent?.name
            SPAN -> defect.span
            SUB_COMPONENT -> observation.subcomponent?.name
            DRAWING_NUMBER -> observation.drawingNumber
            LOCATION -> {
                val observationDefect = observationDefectRepository
                        .findAllByObservationIdAndDeletedIsFalse(observation.id).firstOrNull()
                val photo = observationDefect?.let { photoRepository
                        .findAllByObservationDefectIdAndDeletedIsFalse(observationDefect.uuid).firstOrNull {
                            it.latitude != null && it.longitude != null
                        }
                }
                photo?.let { "${it.latitude}, ${it.longitude}"}
            }
            ROOM_NO -> observation.roomNumber
            DEFECT -> defect.id
            DEFECT_NUMBER -> defect.defect?.number?.toString()
            DEFECT_NAME -> defect.defect?.name
            DEFECT_CONDITION -> (if (defect.type == StructuralType.STRUCTURAL) defect else null)?.condition.let {
                when (it?.type) {
                    ConditionType.GOOD -> "1 - ${it.type}"
                    ConditionType.FAIR -> "2 - ${it.type}"
                    ConditionType.POOR -> "3 - ${it.type}"
                    ConditionType.SEVERE -> "4 - ${it.type}"
                    else -> "5 - ${it?.type}"
                }
            }
            INSPECTION_DATE -> inspection.startDate?.formatDate(DATE_FORMAT)
            STATIONING -> structure?.endStationing
            CRITICAL_FINDINGS -> if (!defect.criticalFindings.isNullOrEmpty())
                defect.criticalFindings?.joinToString(", ") { it.normalName } else ""
            PHOTO_QTY -> photoRepository.countByObservationDefectIdAndDeletedIsFalse(defect.uuid).toString()
        }
    }

    companion object {
        internal val HOURS_AND_MINS_FORMAT = SimpleDateFormat("HH:mm", Locale.getDefault())
        internal val DEFAULT_FORMAT = SimpleDateFormat("dd.MM.yyyy", Locale.getDefault())

        private val LEFT_FIELDS = listOf(OBSERVATION_ID, COMPONENT, SUB_COMPONENT, LOCATION, STATIONING)
        private val RIGHT_FIELDS = listOf(
            INSPECTION_DATE, DEFECT, DEFECT_NUMBER, DEFECT_NAME, DEFECT_CONDITION, CRITICAL_FINDINGS, PHOTO_QTY
        )

        val CELLS_ALIGNMENT_MAP: Map<Alignment, List<DefectFields>> = mapOf(
            Alignment.START to LEFT_FIELDS,
            Alignment.END to RIGHT_FIELDS
        )

    }
}