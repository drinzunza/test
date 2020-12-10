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
import kotlin.math.roundToInt

private const val IMAGES_LING_SIZE = 16.0
private const val TEXT_MAINTENANCE_ITEM = "Maintenance item"

enum class DefectsReportFields(val textElement: TextElement.Simple, private val widthPercent: Float) {
    INDEX(
            TextElement.Simple("Index", styles = MainDocumentFactory.BOLD_STYLE_LIST, textSize = SMALL_TABLE_TEXT_SIZE),
            widthPercent = 0.0417f
    ),
    DEFECT_ID(
            TextElement.Simple("Defect ID", styles = MainDocumentFactory.BOLD_STYLE_LIST, textSize = SMALL_TABLE_TEXT_SIZE),
            widthPercent = 0.0986f
    ),
    OBSERVATION_ID(
            TextElement.Simple("Observation ID", styles = MainDocumentFactory.BOLD_STYLE_LIST, textSize = SMALL_TABLE_TEXT_SIZE),
            widthPercent = 0.0986f
    ),
    SUB_COMPONENT(
            TextElement.Simple("Sub-Component", styles = MainDocumentFactory.BOLD_STYLE_LIST, textSize = SMALL_TABLE_TEXT_SIZE),
            widthPercent = 0.1236f
    ),
    LOCATION_ID(
            TextElement.Simple("Location ID", styles = MainDocumentFactory.BOLD_STYLE_LIST, textSize = SMALL_TABLE_TEXT_SIZE),
            widthPercent = 0.0653f
    ),
    PREV_DEF_NO(
            TextElement.Simple("Prev. def. ID", styles = MainDocumentFactory.BOLD_STYLE_LIST, textSize = SMALL_TABLE_TEXT_SIZE),
            widthPercent = 0.0417f
    ),
    PREV_NO(
            TextElement.Simple("Prev. ID", styles = MainDocumentFactory.BOLD_STYLE_LIST, textSize = SMALL_TABLE_TEXT_SIZE),
            widthPercent = 0.0417f
    ),
    DATE(
            TextElement.Simple("Inspect. Date", styles = MainDocumentFactory.BOLD_STYLE_LIST, textSize = SMALL_TABLE_TEXT_SIZE),
            widthPercent = 0.0653f
    ),
    STATION(
            TextElement.Simple("Station", styles = MainDocumentFactory.BOLD_STYLE_LIST, textSize = SMALL_TABLE_TEXT_SIZE),
            widthPercent = 0.0764f
    ),
    DEFECT_DESCRIPTION(
            TextElement.Simple("Defect Description", styles = MainDocumentFactory.BOLD_STYLE_LIST, textSize = SMALL_TABLE_TEXT_SIZE),
            widthPercent = 0.1194f
    ),
    OBSERVATION_NAME(
            TextElement.Simple("Observation Name", styles = MainDocumentFactory.BOLD_STYLE_LIST, textSize = SMALL_TABLE_TEXT_SIZE),
            widthPercent = 0.1194f
    ),
    SIZE(
            TextElement.Simple("Size", styles = MainDocumentFactory.BOLD_STYLE_LIST, textSize = SMALL_TABLE_TEXT_SIZE),
            widthPercent = 0.0458f
    ),
    IMAGE(
            TextElement.Simple("Image", styles = MainDocumentFactory.BOLD_STYLE_LIST, textSize = SMALL_TABLE_TEXT_SIZE),
            widthPercent = 0.0375f
    ),
    CS_RATING(
            TextElement.Simple("CS", styles = MainDocumentFactory.BOLD_STYLE_LIST, textSize = SMALL_TABLE_TEXT_SIZE),
            widthPercent = 0.0361f
    ),
    STATUS(
            TextElement.Simple("Status", styles = MainDocumentFactory.BOLD_STYLE_LIST, textSize = SMALL_TABLE_TEXT_SIZE),
            widthPercent = 0.05f
    ),
    CORR_ACTION(
            TextElement.Simple("Corr. Action", styles = MainDocumentFactory.BOLD_STYLE_LIST, textSize = SMALL_TABLE_TEXT_SIZE),
            widthPercent = 0.0458f
    ),
    REPAIR_METHOD(
            TextElement.Simple("Repair Method", styles = MainDocumentFactory.BOLD_STYLE_LIST, textSize = SMALL_TABLE_TEXT_SIZE),
            widthPercent = 0.0757f
    ),
    REPAIR_DATE(
            TextElement.Simple("Repair Date", styles = MainDocumentFactory.BOLD_STYLE_LIST, textSize = SMALL_TABLE_TEXT_SIZE),
            widthPercent = 0.0757f
    );

    fun getCellWidth(rowWidth: Int?): Int? = rowWidth?.toFloat()?.times(widthPercent)?.roundToInt()

    companion object {

        private val FIELDS_CELLS = mapOf(
                StructuralType.STRUCTURAL to listOf(
                        INDEX,
                        DEFECT_ID,
                        SUB_COMPONENT,
                        LOCATION_ID,
                        PREV_DEF_NO,
                        DATE,
                        STATION,
                        DEFECT_DESCRIPTION,
                        SIZE,
                        IMAGE,
                        CS_RATING,
                        STATUS,
                        CORR_ACTION,
                        REPAIR_METHOD,
                        REPAIR_DATE
                ),
                StructuralType.MAINTENANCE to listOf(
                        INDEX,
                        OBSERVATION_ID,
                        SUB_COMPONENT,
                        LOCATION_ID,
                        PREV_NO,
                        DATE,
                        STATION,
                        OBSERVATION_NAME,
                        SIZE,
                        IMAGE,
                        CS_RATING,
                        STATUS,
                        CORR_ACTION,
                        REPAIR_METHOD,
                        REPAIR_DATE
                )
        )

        fun Table.Builder.buildHeaderRow(type: StructuralType) {
            val tableWidth = width
            row {
                FIELDS_CELLS[type]?.forEach { field: DefectsReportFields ->
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

        private fun convertCsRating(conditionType: ConditionType?): String = when (conditionType) {
            ConditionType.GOOD -> "1"
            ConditionType.FAIR -> "2"
            ConditionType.POOR -> "3"
            ConditionType.SEVERE -> "4"
            else -> EMPTY_CELL_VALUE
        }

        fun Table.Builder.buildRows(
                inspection: Inspection, inspector: User,
                type: StructuralType, server: String
        ) {
            var coloredCell = true
            inspection.observations
                    ?.sortedWith(compareBy({it.component?.name}, {it.subcomponent?.name}))
                    ?.forEach { observation ->
                observation.defects
                        ?.filter { type == it.type }
                        ?.sortedBy { it.stationMarker }
                        ?.also {
                            coloredCell = !coloredCell
                        }
                        ?.forEachIndexed { defectIndex, defect ->
                            row {
                                FIELDS_CELLS[type]?.forEach { field: DefectsReportFields ->
                                    cell {
                                        width = field.getCellWidth(this@buildRows.width)
                                        color = if (coloredCell) ReportConstants.COLOR_GRAY else null

                                        addParagraph(rows.size, inspection, inspector, observation, defect, defectIndex, field, type, server)
                                    }
                                }
                            }
                        }
            }
        }

        private fun ObservationDefect.getWeatherText(): String? {
            return if (temperature != null) "T $temperature℉ Hum $humidity% Wind $wind m/h" else null
        }

        private fun Table.Row.Cell.Builder.addParagraph(
                rowIndex: Int,
                inspection: Inspection,
                inspector: User,
                observation: Observation,
                defect: ObservationDefect,
                defectIndex: Int,
                field: DefectsReportFields,
                type: StructuralType,
                server: String
        ) {
            paragraph {
                alignment = Alignment.START
                when (field) {
                    INDEX -> addCellText(rowIndex.toString())
                    DEFECT_ID, OBSERVATION_ID -> addCellText(defect.id)
                    SUB_COMPONENT -> addCellText(if (defectIndex == 0) observation.reportComponentName else null)
                    LOCATION_ID -> addCellText(defect.span, TEXT_NOT_APPLICABLE)
                    DATE -> addCellText(inspection.endDate?.let { SimpleDateFormat("MM/dd/yy", Locale.US).format(it.toDate()) }
                            ?: EMPTY_CELL_VALUE)
                    STATION -> addCellText(defect.stationMarker)
                    OBSERVATION_NAME -> addCellText(defect.toMaintenance()?.observationName?.name)
                    DEFECT_DESCRIPTION -> addCellText(defect.toStructural()?.defect?.name)
                    SIZE -> when (type) {
                        StructuralType.MAINTENANCE -> addCellText(TEXT_NOT_APPLICABLE)
                        StructuralType.STRUCTURAL -> addCellText(defect.toStructural()?.getSizeWithMeasureUnits(observation))
                    }
                    IMAGE -> {
                        alignment = Alignment.CENTER
                        createDefectPhotoGalleryUrl(server, defect, inspection, inspector)?.let { url: String ->
                            iconLink(url, drawableRes = "icon_images_report.png", size = IMAGES_LING_SIZE)
                        }

                        alignment = Alignment.CENTER
                    }
                    CORR_ACTION -> {
                        alignment = Alignment.CENTER
                        addCellText(defect.observationType?.letter())
                    }
                    CS_RATING -> {
                        alignment = Alignment.CENTER
                        when (type) {
                            StructuralType.MAINTENANCE -> addCellText(TEXT_NOT_APPLICABLE)
                            StructuralType.STRUCTURAL -> addCellText(convertCsRating(defect.toStructural()?.condition?.type))
                        }
                    }
                    REPAIR_METHOD -> {
                        alignment = Alignment.CENTER
                        addCellText(defect.repairMethod)
                    }
                    REPAIR_DATE -> {
                        alignment = Alignment.CENTER
                        addCellText(defect.repairDate)
                    }
                    PREV_DEF_NO -> {
                        alignment = Alignment.CENTER
                        addCellText(defect.previousDefectNumber)
                    }
                    PREV_NO -> {
                        alignment = Alignment.CENTER
                        addCellText(defect.previousDefectNumber)
                    }
                    else -> addCellText()
                }
            }
        }

        private fun Paragraph.Builder.addCellText(text: String? = null, emptyValue: String = EMPTY_CELL_VALUE) {
            text(text ?: emptyValue, textSize = SMALL_TABLE_TEXT_SIZE)
        }
    }
}