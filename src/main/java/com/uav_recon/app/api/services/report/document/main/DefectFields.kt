package com.uav_recon.app.api.services.report.document.main

import com.uav_recon.app.api.entities.db.Inspection
import com.uav_recon.app.api.entities.db.Observation
import com.uav_recon.app.api.entities.db.ObservationDefect
import com.uav_recon.app.api.repositories.ObservationDefectRepository
import com.uav_recon.app.api.repositories.PhotoRepository
import com.uav_recon.app.api.services.report.document.models.body.Paragraph

internal enum class DefectFields(val title: String) {

    OBSERVATION_ID("Observation Id: "),
    COMPONENT("Component: "),
    SUB_COMPONENT("Sub-component name: "),
    MATERIAL("Material: "),
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

    fun getValue(inspection: Inspection, observation: Observation, defect: ObservationDefect,
                 observationDefectRepository: ObservationDefectRepository,
                 photoRepository: PhotoRepository
    ): String? {
        return when (this) {
            OBSERVATION_ID -> observation.code
            COMPONENT -> observation.structuralComponent?.name
            SUB_COMPONENT -> observation.subcomponent?.name
            MATERIAL -> defect.material?.name
            DRAWING_NUMBER -> observation.drawingNumber
            LOCATION -> observationDefectRepository.findAllByObservationIdAndDeletedIsFalse(observation.id).getOrNull(0)?.let {
                photoRepository.findAllByObservationDefectIdAndDeletedIsFalse(it.id).firstOrNull {
                    it.latitude != null && it.longitude != null
                }?.let {
                    "${it.latitude}, ${it.longitude}"
                }
            }
            ROOM_NO -> observation.roomNumber
            DEFECT -> defect.id
            DEFECT_NUMBER -> defect.defect?.number?.toString()
            DEFECT_NAME -> defect.defect?.name
            DEFECT_CONDITION -> defect.condition.let {
                when (it?.type) {
                    "GOOD" -> "1 - ${it.type}"
                    "FAIR" -> "2 - ${it.type}"
                    "POOR" -> "3 - ${it.type}"
                    "SEVERE" -> "4 - ${it.type}"
                    else -> "5 - ${it?.type}"
                }
            }
            INSPECTION_DATE -> ""//inspection.startDate?.formatDate(DATE_FORMAT)
            STATIONING -> inspection.structure?.endStationing
            CRITICAL_FINDINGS -> defect.criticalFindings?.joinToString(separator = ",")
            PHOTO_QTY -> photoRepository.findAllByObservationDefectIdAndDeletedIsFalse(defect.id).size.toString()
        }
    }

    companion object {

        private val LEFT_FIELDS = listOf(
            OBSERVATION_ID, COMPONENT, SUB_COMPONENT,
            MATERIAL, DRAWING_NUMBER, LOCATION, ROOM_NO
        )
        private val RIGHT_FIELDS = listOf(
            DEFECT, DEFECT_NUMBER, DEFECT_NAME, DEFECT_CONDITION,
            INSPECTION_DATE, STATIONING, CRITICAL_FINDINGS, PHOTO_QTY
        )

        val CELLS_ALIGNMENT_MAP: Map<Paragraph.Alignment, List<DefectFields>> = mapOf(
            Paragraph.Alignment.LEFT to LEFT_FIELDS,
            Paragraph.Alignment.RIGHT to RIGHT_FIELDS
        )

    }

}
