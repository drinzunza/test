package com.uav_recon.app.api.services.report.document.main

import com.uav_recon.app.api.entities.db.*
import com.uav_recon.app.api.services.report.ReportConstants
import com.uav_recon.app.api.services.report.document.models.body.Alignment
import com.uav_recon.app.api.services.report.document.models.body.Paragraph
import com.uav_recon.app.api.services.report.document.models.body.Table
import com.uav_recon.app.api.services.report.document.models.elements.TextElement
import com.uav_recon.app.api.utils.*
import java.text.SimpleDateFormat
import java.util.*
import kotlin.collections.ArrayList
import kotlin.collections.HashMap
import kotlin.math.roundToInt

private const val IMAGES_LING_SIZE = 16.0

internal class DefectReportFields(private val flavor: String = "default", private val isTunnelStructure: Boolean = false) {

    private val map = HashMap<StructuralType, ArrayList<DefectReportField>>()

    init {
        map[StructuralType.STRUCTURAL] = ArrayList()
        map[StructuralType.MAINTENANCE] = ArrayList()

        addStructuralField("index", 0.0417f, INDEX_TAG)
        addStructuralField("defect_id", 0.0986f, DEFECT_TAG)
        addStructuralField("sub_component", 0.1236f, SUB_COMPONENT_TAG)
        if (CustomReportManager.getInstance().isVisible("location_id_column", flavor)) {
            addStructuralField("location_id", 0.0653f, LOCATION_TAG)
        }
        addStructuralField("prev_def_id", 0.0417f, PREV_DEF_ID_TAG)
        addStructuralField("inspection_date_table", 0.0653f, DATE_TAG)
        if (CustomReportManager.getInstance().isVisible("station_column", flavor)) {
            addStructuralField("station", 0.0764f, STATION_TAG)
        }
        addStructuralField("defect_description_table", 0.1194f, DEFECT_DESCRIPTION_TAG)
        addStructuralField("size", 0.0458f, SIZE_TAG)
        addStructuralField("image", 0.0375f, IMAGE_TAG)
        addStructuralField("cs", 0.0361f, CS_TAG)
        if (CustomReportManager.getInstance().isVisible("critical_findings_column", flavor)) {
            addStructuralField("critical_findings_table", 0.06f, CRITICAL_FINDING_TAG)
        }
        if (CustomReportManager.getInstance().isVisible("corrective_action_column", flavor)) {
            addStructuralField("corrective_action", 0.0458f, CORRECTIVE_ACTION_TAG)
        }
        if (isTunnelStructure) {
            addStructuralField("o_clock", 0.0653f, O_CLOCK_POSITION_TAG)
        }
        addStructuralField("repair_method", 0.0757f, REPAIR_TAG)
        addStructuralField("repair_date", 0.0657f, REPAIR_DATE_TAG)

        addMaintenanceField("index", 0.0417f, INDEX_TAG)
        addMaintenanceField("observation_id", 0.0986f, OBSERVATION_ID_TAG)
        addMaintenanceField("sub_component", 0.1236f, SUB_COMPONENT_TAG)
        addMaintenanceField("location_id", 0.0653f, LOCATION_TAG)
        addMaintenanceField("prev_obs_id", 0.0417f, PREV_OBSERVATION_ID_TAG)
        addMaintenanceField("inspection_date_table", 0.0653f, DATE_TAG)
        addMaintenanceField("station", 0.0764f, STATION_TAG)
        addMaintenanceField("observation_name", 0.1194f, OBSERVATION_NAME_TAG)
        addMaintenanceField("size", 0.0458f, SIZE_TAG)
        addMaintenanceField("image", 0.0375f, IMAGE_TAG)
        addMaintenanceField("critical_findings_table", 0.06f, CRITICAL_FINDING_TAG)
        addMaintenanceField("corrective_action", 0.0458f, CORRECTIVE_ACTION_TAG)
        if (isTunnelStructure) {
            addMaintenanceField("o_clock", 0.0653f, O_CLOCK_POSITION_TAG)
        }
        addMaintenanceField("repair_method", 0.0757f, REPAIR_TAG)
        addMaintenanceField("repair_date", 0.0657f, REPAIR_DATE_TAG)
    }

    private fun addMaintenanceField(stringId: String, widthPercent: Float, tag: String) {
        map[StructuralType.MAINTENANCE]?.add(DefectReportField(TextElement.Simple(CustomReportManager.getInstance().getString(stringId, flavor), styles = MainDocumentFactory.BOLD_STYLE_LIST,
                textSize = SMALL_TABLE_TEXT_SIZE), widthPercent, tag))
    }

    private fun addStructuralField(stringId: String, widthPercent: Float, tag: String) {
        map[StructuralType.STRUCTURAL]?.add(DefectReportField(TextElement.Simple(CustomReportManager.getInstance().getString(stringId, flavor), styles = MainDocumentFactory.BOLD_STYLE_LIST,
                textSize = SMALL_TABLE_TEXT_SIZE), widthPercent, tag))
    }

    fun buildHeaderRow(tableBuilder: Table.Builder, type: StructuralType) {
        tableBuilder.apply {
            val tableWidth = width
            row {
                map[type]?.forEach { field: DefectReportField ->
                    cell {
                        width { field.getCellWidth(tableWidth) }
                        paragraph {
                            alignment = Alignment.START
                            element { field.textElement }
                        }
                    }
                }
            }
        }
    }

    fun buildRows(tableBuilder: Table.Builder,
                  inspection: Inspection, inspector: User,
                  type: StructuralType, server: String,
                  sortByStationing: Boolean,
                  isInverse: Boolean
    ) {
        tableBuilder.apply {
            var coloredCell = true
            // Put all defects in one list.
            var defectList: MutableList<ObservationDefect> = ArrayList()
            // Create a map of defect id to observation for faster access.
            val defectToObservationMap: HashMap<String, Observation> = HashMap()
            inspection.observations?.forEach { observation ->
                observation.defects?.forEach {
                    defectList.add(it)
                    defectToObservationMap[it.id] = observation
                }
            }

            if (sortByStationing) {
                defectList = defectList.sortedWith(compareBy { it.stationMarker }).toMutableList()
            }


            defectList.filter { type == it.type }
                    .also {
                        coloredCell = !coloredCell
                    }
                    .forEachIndexed { defectIndex, defect ->
                        row {
                            map[type]?.forEach { field: DefectReportField ->
                                cell {
                                    width = field.getCellWidth(this.width)
                                    color = if (coloredCell) ReportConstants.COLOR_GRAY else null
                                    addParagraph(rows.size, inspection, inspector, defectToObservationMap[defect.id]!!, defect, defectIndex, field.tag, type, server, isInverse)
                                }
                            }
                        }
                    }
        }

    }

    private fun Table.Row.Cell.Builder.addParagraph(
            rowIndex: Int,
            inspection: Inspection,
            inspector: User,
            observation: Observation,
            defect: ObservationDefect,
            defectIndex: Int,
            tag: String,
            type: StructuralType,
            server: String,
            isInverse: Boolean
    ) {
        paragraph {
            alignment = Alignment.START
            when (tag) {
                INDEX_TAG -> addCellText(rowIndex.toString())
                DEFECT_TAG, OBSERVATION_ID_TAG -> addCellText(defect.id)
                SUB_COMPONENT_TAG -> addCellText(observation.reportComponentName)
                LOCATION_TAG -> addCellText(defect.span, TEXT_NOT_APPLICABLE)
                DATE_TAG -> {
                    addCellText(defect.createdAtClient?.let {
                        SimpleDateFormat("MM/dd/yy", Locale.US).format(it.toDate())
                    } ?: EMPTY_CELL_VALUE)
                }
                STATION_TAG -> addCellText(defect.stationMarker)
                OBSERVATION_NAME_TAG -> addCellText(defect.toMaintenance()?.observationName?.name)
                DEFECT_DESCRIPTION_TAG -> addCellText(defect.toStructural()?.defect?.name)
                SIZE_TAG -> when (type) {
                    StructuralType.MAINTENANCE -> addCellText(TEXT_NOT_APPLICABLE)
                    StructuralType.STRUCTURAL -> addCellText(defect.toStructural()?.getSizeWithMeasureUnits(observation))
                }
                IMAGE_TAG -> {
                    alignment = Alignment.CENTER
                    createDefectPhotoGalleryUrl(server, defect, inspection, inspector)?.let { url: String ->
                        iconLink(url, drawableRes = "icon_images_report.png", size = IMAGES_LING_SIZE)
                    }

                    alignment = Alignment.CENTER
                }
                CORRECTIVE_ACTION_TAG -> {
                    alignment = Alignment.CENTER
                    addCellText(defect.observationType?.letter())
                }
                CS_TAG -> {
                    alignment = Alignment.CENTER
                    when (type) {
                        StructuralType.MAINTENANCE -> addCellText(TEXT_NOT_APPLICABLE)
                        StructuralType.STRUCTURAL -> addCellText(convertCsRating(defect.toStructural()?.condition?.type, isInverse))
                    }
                }
                REPAIR_TAG -> {
                    alignment = Alignment.CENTER
                    addCellText(defect.repairMethod)
                }
                REPAIR_DATE_TAG -> {
                    alignment = Alignment.CENTER
                    addCellText(defect.repairDate)
                }
                CRITICAL_FINDING_TAG -> {
                    alignment = Alignment.CENTER
                    addCellText(defect.criticalFindings?.joinToString(",\n") { it.name.toLowerCase().capitalize() })
                }
                PREV_DEF_ID_TAG -> {
                    alignment = Alignment.CENTER
                    addCellText(defect.previousDefectNumber)
                }
                PREV_OBSERVATION_ID_TAG -> {
                    alignment = Alignment.CENTER
                    addCellText(defect.previousDefectNumber)
                }
                O_CLOCK_POSITION_TAG -> {
                    alignment = Alignment.CENTER
                    addCellText(if (defect.clockPosition == null) null else defect.clockPosition.toString(), TEXT_NOT_APPLICABLE)
                }
                else -> addCellText()
            }
        }
    }

    private fun Paragraph.Builder.addCellText(text: String? = null, emptyValue: String = EMPTY_CELL_VALUE) {
        text(text ?: emptyValue, textSize = SMALL_TABLE_TEXT_SIZE)
    }

    private fun createDefectPhotoGalleryUrl(server: String, defect: ObservationDefect, inspection: Inspection, inspector: User): String? {
        val inspectorId = inspector.id ?: return null
        val inspectionId = inspection.uuid
        val observationId = inspection.observations?.firstOrNull {
            it.defects?.any { d -> d.id == defect.id } ?: false
        }?.uuid

        return "$server/datarecon-links/$inspectorId/$inspectionId/$observationId/${defect.uuid}"
    }

    private val Observation.reportComponentName: String?
        get() {
            val subComponentName = subcomponent?.name
            return when {
                subComponentName.equals("n/a") -> component?.name
                else -> subComponentName
            }
        }

    private fun convertCsRating(conditionType: ConditionType?, isInverse: Boolean): String {
        if (isInverse) {
            return when (conditionType) {
                ConditionType.GOOD -> "4"
                ConditionType.FAIR -> "3"
                ConditionType.POOR -> "2"
                ConditionType.SEVERE -> "1"
                else -> EMPTY_CELL_VALUE
            }
        }else{
            return when (conditionType) {
                ConditionType.GOOD -> "1"
                ConditionType.FAIR -> "2"
                ConditionType.POOR -> "3"
                ConditionType.SEVERE -> "4"
                else -> EMPTY_CELL_VALUE
            }
        }
    }

    class DefectReportField(val textElement: TextElement.Simple, private val widthPercent: Float, val tag: String) {

        fun getCellWidth(rowWidth: Int?): Int? = rowWidth?.toFloat()?.times(widthPercent)?.roundToInt()

    }

    companion object {
        const val INDEX_TAG = "INDEX_TAG"
        const val DEFECT_TAG = "DEFECT_TAG"
        const val SUB_COMPONENT_TAG = "SUB_COMPONENT_TAG"
        const val LOCATION_TAG = "LOCATION_TAG"
        const val PREV_DEF_ID_TAG = "PREV_DEF_ID_TAG"
        const val DATE_TAG = "DATE_TAG"
        const val STATION_TAG = "STATION_TAG"
        const val DEFECT_DESCRIPTION_TAG = "DEFECT_DESCRIPTION_TAG"
        const val SIZE_TAG = "SIZE_TAG"
        const val IMAGE_TAG = "IMAGE_TAG"
        const val CS_TAG = "CS_TAG"
        const val CRITICAL_FINDING_TAG = "CRITICAL_FINDING_TAG"
        const val CORRECTIVE_ACTION_TAG = "CORRECTIVE_ACTION_TAG"
        const val REPAIR_TAG = "REPAIR_TAG"
        const val REPAIR_DATE_TAG = "REPAIR_DATE"
        const val OBSERVATION_ID_TAG = "OBSERVATION_ID_TAG"
        const val PREV_OBSERVATION_ID_TAG = "PREV_OBSERVATION_ID_TAG"
        const val OBSERVATION_NAME_TAG = "OBSERVATION_NAME_TAG"
        const val O_CLOCK_POSITION_TAG = "O_CLOCK_POSITION_TAG"
    }


}
