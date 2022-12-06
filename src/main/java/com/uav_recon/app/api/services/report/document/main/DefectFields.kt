package com.uav_recon.app.api.services.report.document.main

import com.uav_recon.app.api.entities.db.*
import com.uav_recon.app.api.services.report.document.main.MainDocumentFactory.Companion.DATE_FORMAT
import com.uav_recon.app.api.services.report.document.models.body.Alignment
import com.uav_recon.app.api.utils.*

internal class DefectFields(private val flavor: String = "default", private val isTunnelStructure: Boolean = false) {

    private val structuralLeftFields = ArrayList<DefectField>()
    private val structuralRightFields = ArrayList<DefectField>()
    private val maintenanceLeftFields = ArrayList<DefectField>()
    private val maintenanceRightFields = ArrayList<DefectField>()

    private var structureAlignmentMap: Map<Alignment, List<DefectField>>
    private var maintenanceAlignmentMap: Map<Alignment, List<DefectField>>

    init {
        addStructuralLeftField("component_key", COMPONENT_TAG)
        addStructuralLeftField("sub_component_key", SUB_COMPONENT_TAG)
        addStructuralLeftField("subdivision_number_key", SUBDIVISION_TAG)
        if (CustomReportManager.getInstance().isVisible("station_column", flavor)) {
            addStructuralLeftField("station_key", STATION_TAG)
        }
        if (CustomReportManager.getInstance().isVisible("location_id_column", flavor)) {
            addStructuralLeftField("location_key", LOCATION_TAG)
        }
        if (isTunnelStructure) {
            addStructuralLeftField("o_clock_key", O_CLOCK_POSITION_TAG)
        }
        addStructuralLeftField("size_key", SIZE_TAG)
        addStructuralLeftField("defect_status_key", STATUS_TAG)
        addStructuralRightField("inspection_date_key", DATE_TAG)
        addStructuralRightField("defect_id_key", DEFECT_TAG)
        addStructuralRightField("defect_name_key", DEFECT_NAME_TAG)
        addStructuralRightField("defect_condition_key", CONDITION_TAG)
        addStructuralRightField("photo_qty_key", PHOTO_QUANTITY_TAG)
        if (CustomReportManager.getInstance().isVisible("critical_findings_column", flavor)) {
            addStructuralRightField("critical_key", CRITICAL_FINDING_TAG)
        }

        addMaintenanceLeftField("component_key", COMPONENT_TAG)
        addMaintenanceLeftField("sub_component_key", SUB_COMPONENT_TAG)
        if (CustomReportManager.getInstance().isVisible("station_column", flavor)) {
            addMaintenanceLeftField("station_key", STATION_TAG)
        }
        if (CustomReportManager.getInstance().isVisible("location_id_column", flavor)) {
            addMaintenanceLeftField("location_key", LOCATION_TAG)
        }
        if (isTunnelStructure) {
            addMaintenanceLeftField("o_clock_key", O_CLOCK_POSITION_TAG)
        }
        addMaintenanceLeftField("defect_status_key", STATUS_TAG)

        addMaintenanceRightField("inspection_date_key", DATE_TAG)
        addMaintenanceRightField("observation_id_key", OBSERVATION_ID_TAG)
        addMaintenanceRightField("observation_name_key", OBSERVATION_NAME_TAG)
        addMaintenanceRightField("photo_qty_key", PHOTO_QUANTITY_TAG)
        if (CustomReportManager.getInstance().isVisible("critical_findings_column", flavor)) {
            addMaintenanceRightField("critical_key", CRITICAL_FINDING_TAG)
        }

        structureAlignmentMap = mapOf(Alignment.START to structuralLeftFields, Alignment.END to structuralRightFields)
        maintenanceAlignmentMap = mapOf(Alignment.START to maintenanceLeftFields, Alignment.END to maintenanceRightFields)
    }

    fun getCellAlignmentMap(defect: ObservationDefect): Map<Alignment, List<DefectField>> {
        return when (defect.type) {
            StructuralType.STRUCTURAL -> structureAlignmentMap
            StructuralType.MAINTENANCE -> maintenanceAlignmentMap
            else -> structureAlignmentMap
        }
    }

    private fun addStructuralLeftField(title_key: String, tag: String) {
        structuralLeftFields.add(DefectField(CustomReportManager.getInstance().getString(title_key, flavor), tag))
    }

    private fun addStructuralRightField(title_key: String, tag: String) {
        structuralRightFields.add(DefectField(CustomReportManager.getInstance().getString(title_key, flavor), tag))
    }

    private fun addMaintenanceLeftField(title_key: String, tag: String) {
        maintenanceLeftFields.add(DefectField(CustomReportManager.getInstance().getString(title_key, flavor), tag))
    }

    private fun addMaintenanceRightField(title_key: String, tag: String) {
        maintenanceRightFields.add(DefectField(CustomReportManager.getInstance().getString(title_key, flavor), tag))
    }

    companion object {
        const val COMPONENT_TAG = "COMPONENT_TAG"
        const val DEFECT_TAG = "DEFECT_TAG"
        const val SUB_COMPONENT_TAG = "SUB_COMPONENT_TAG"
        const val LOCATION_TAG = "LOCATION_TAG"
        const val DATE_TAG = "DATE_TAG"
        const val STATION_TAG = "STATION_TAG"
        const val SIZE_TAG = "SIZE_TAG"
        const val CRITICAL_FINDING_TAG = "CRITICAL_FINDING_TAG"
        const val OBSERVATION_ID_TAG = "OBSERVATION_ID_TAG"
        const val OBSERVATION_NAME_TAG = "OBSERVATION_NAME_TAG"
        const val O_CLOCK_POSITION_TAG = "O_CLOCK_POSITION_TAG"
        const val DEFECT_NAME_TAG = "DEFECT_NAME_TAG"
        const val CONDITION_TAG = "CONDITION_TAG"
        const val PHOTO_QUANTITY_TAG = "PHOTO_QUANTITY_TAG"
        const val STATUS_TAG = "STATUS_TAG"
        const val SUBDIVISION_TAG = "SUBDIVISION_TAG"
    }


    class DefectField(val title: String, val tag: String) {

        fun getValue(inspection: Inspection, structure: Structure?, observation: Observation, defect: ObservationDefect, tag: String): String? {
            return when (tag) {
                COMPONENT_TAG -> observation.component?.name
                SUB_COMPONENT_TAG -> observation.subcomponent?.name
                DEFECT_TAG, OBSERVATION_ID_TAG -> defect.id
                OBSERVATION_NAME_TAG -> defect.toMaintenance()?.observationName?.name
                DEFECT_NAME_TAG -> defect.toStructural()?.defect?.name
                CONDITION_TAG -> defect.toStructural()?.condition?.let {
                    "${it.type.ordinal + 1} - ${it.type.normalName}"
                }
                DATE_TAG -> defect.createdAtClient?.formatDate(DATE_FORMAT)
                STATION_TAG -> defect.stationMarker
                CRITICAL_FINDING_TAG -> if (defect.criticalFindings.isNullOrEmpty()) "NONE" else defect.criticalFindings?.joinToString(separator = ", ") { it.finding }
                PHOTO_QUANTITY_TAG -> defect.photos?.size?.toString() ?: "0"
                LOCATION_TAG -> defect.span
                SIZE_TAG -> {
                    when (defect.type) {
                        StructuralType.STRUCTURAL -> defect.toStructural()?.getSizeWithMeasureUnits(observation)
                        StructuralType.MAINTENANCE -> null
                        else -> null
                    }
                }
                O_CLOCK_POSITION_TAG -> if (defect.clockPosition == null) null else defect.clockPosition.toString()
                STATUS_TAG -> defect.status.toString()
                SUBDIVISION_TAG -> defect.structureSubdivision?.number
                else -> ""
            }
        }


    }

}