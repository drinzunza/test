package com.uav_recon.app.api.services.report.document.main

import com.uav_recon.app.api.entities.db.*
import com.uav_recon.app.api.repositories.ComponentRepository
import com.uav_recon.app.api.repositories.ObservationDefectRepository
import com.uav_recon.app.api.repositories.PhotoRepository
import com.uav_recon.app.api.repositories.SubcomponentRepository
import com.uav_recon.app.api.services.report.document.main.MainDocumentFactory.Companion.DATE_FORMAT
import com.uav_recon.app.api.services.report.document.models.body.Alignment
import com.uav_recon.app.api.utils.formatDate
import com.uav_recon.app.api.utils.normalName

private const val NONE = "NONE"

internal enum class DefectFields(val title: String) {

    COMPONENT("Component: "),
    SPAN("Span #: "),
    SUB_COMPONENT("Sub-component name: "),
    DRAWING_NUMBER("Drawing Number: "),
    ROOM_NO("Room No.: "),
    DEFECT_ID("Defect ID: "),
    OBSERVATION_ID("Observation ID: "),
    DEFECT_NAME("Defect Name: "),
    OBSERVATION_NAME("Observation Name: "),
    DEFECT_CONDITION("Defect Condition State: "),
    INSPECTION_DATE("Inspection date: "),
    STATIONING("Stationing: "),
    CRITICAL_FINDINGS("Critical Findings: "),
    PHOTO_QTY("Photo QTY's: "),
    LOCATION_ID("Location ID: ");

    fun getValue(inspection: Inspection, structure: Structure?,
                 observation: Observation, defect: ObservationDefect,
                 photoRepository: PhotoRepository
    ): String? {
        return when (this) {
            COMPONENT -> observation.structuralComponent?.name
            SPAN -> defect.span
            SUB_COMPONENT -> observation.subcomponent?.name
            DRAWING_NUMBER -> observation.drawingNumber
            ROOM_NO -> observation.roomNumber
            DEFECT_ID, OBSERVATION_ID -> defect.id
            DEFECT_NAME, OBSERVATION_NAME -> defect.defect?.name
            DEFECT_CONDITION -> (if (defect.type == StructuralType.STRUCTURAL) defect else null)?.condition?.let {
                "${it.type.ordinal + 1} - ${it.type.normalName}"
            }
            INSPECTION_DATE -> inspection.startDate?.formatDate(DATE_FORMAT)
            STATIONING -> defect.stationMarker
            CRITICAL_FINDINGS -> if (defect.criticalFindings.isNullOrEmpty()) NONE else defect.criticalFindings?.size.toString()
            PHOTO_QTY -> photoRepository.countByObservationDefectIdAndDeletedIsFalse(defect.uuid).toString()

            LOCATION_ID -> defect.span
        }
    }

    companion object {

        private val LEFT_FIELDS = listOf(COMPONENT, SUB_COMPONENT, STATIONING, LOCATION_ID)
        private val STRUCTURAL_RIGHT_FIELDS = listOf(
            INSPECTION_DATE, DEFECT_ID, DEFECT_NAME, DEFECT_CONDITION, CRITICAL_FINDINGS, PHOTO_QTY
        )
        private val MAINTENANCE_RIGHT_FIELDS = listOf(
            INSPECTION_DATE, OBSERVATION_ID, OBSERVATION_NAME, CRITICAL_FINDINGS, PHOTO_QTY
        )

        private val STRUCTURAL_ALIGNMENT_MAP =  mapOf(
            Alignment.START to LEFT_FIELDS,
            Alignment.END to STRUCTURAL_RIGHT_FIELDS
        )
        private val MAINTENANCE_ALIGNMENT_MAP =  mapOf(
            Alignment.START to LEFT_FIELDS,
            Alignment.END to MAINTENANCE_RIGHT_FIELDS
        )

        fun getCellAlignmentMap(defect: ObservationDefect): Map<Alignment, List<DefectFields>> {
            return when (defect.type) {
                StructuralType.STRUCTURAL -> STRUCTURAL_ALIGNMENT_MAP
                StructuralType.MAINTENANCE -> MAINTENANCE_ALIGNMENT_MAP
                else -> STRUCTURAL_ALIGNMENT_MAP
            }
        }
    }
}