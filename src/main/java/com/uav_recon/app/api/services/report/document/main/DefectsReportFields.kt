package com.uav_recon.app.api.services.report.document.main

import com.uav_recon.app.api.entities.db.*
import com.uav_recon.app.api.services.report.ReportConstants
import com.uav_recon.app.api.services.report.document.models.body.Alignment
import com.uav_recon.app.api.services.report.document.models.body.Paragraph
import com.uav_recon.app.api.services.report.document.models.body.Table
import com.uav_recon.app.api.services.report.document.models.elements.TextElement
import com.uav_recon.app.api.utils.*
import java.text.SimpleDateFormat
import java.time.OffsetDateTime
import java.util.*
import javax.xml.soap.Text
import kotlin.collections.ArrayList
import kotlin.collections.HashMap
import kotlin.math.roundToInt

private const val IMAGES_LING_SIZE = 16.0
private const val TEXT_MAINTENANCE_ITEM = "Maintenance item"

 class DefectsReportFields(val textElement: TextElement.Simple, private val widthPercent: Float) {


    companion object {

        fun getCellWidth(rowWidth: Int?, widthPercent: Float): Int? = rowWidth?.toFloat()?.times(widthPercent)?.roundToInt()

        fun Table.Builder.buildHeaderRow(fields: List<Triple<TextElement, Float, String>>?) {
            val tableWidth = width
            row {
                fields?.forEach { field: Triple<TextElement, Float, String> ->
                    cell {
                        width { getCellWidth(tableWidth, field.second) }
                        paragraph {
                            alignment = Alignment.START
                            element { field.first }
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
                type: StructuralType, server: String,
                sortByStationing: Boolean,
                fields: List<Triple<TextElement, Float, String>>?

        ) {
            var coloredCell = true
            // Put all defects in one list.
            var defectList : MutableList<ObservationDefect> = ArrayList()
            // Create a map of defect id to observation for faster access.
            val defectToObservationMap : HashMap<String, Observation> = HashMap()
            inspection.observations?.forEach { observation ->
                observation.defects?.forEach {
                    defectList.add(it)
                    defectToObservationMap[it.id] = observation
                }
            }

            if(sortByStationing){
                defectList = defectList.sortedWith(compareBy { it.stationMarker }).toMutableList()
            }


            defectList.filter { type == it.type }
                    .also {
                            coloredCell = !coloredCell
                        }
                    .forEachIndexed { defectIndex, defect ->
                        row {
                            fields?.forEach { field: Triple<TextElement, Float, String> ->
                                cell {
                                    width = getCellWidth(this@buildRows.width, field.second)
                                    color = if (coloredCell) ReportConstants.COLOR_GRAY else null

                                    addParagraph(rows.size, inspection, inspector, defectToObservationMap[defect.id]!!, defect, defectIndex, field.third, type, server)
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
                fieldTag: String,
                type: StructuralType,
                server: String
        ) {
            paragraph {
                alignment = Alignment.START
                when (fieldTag) {
                    MainDocumentFactory.INDEX_TAG -> addCellText(rowIndex.toString())
                    MainDocumentFactory.DEFECT_TAG, MainDocumentFactory.OBSERVATION_ID_TAG -> addCellText(defect.id)
                    MainDocumentFactory.SUB_COMPONENT_TAG -> addCellText(observation.reportComponentName)
                    MainDocumentFactory.LOCATION_TAG -> addCellText(defect.span, TEXT_NOT_APPLICABLE)
                    MainDocumentFactory.DATE_TAG -> {
                        addCellText(defect.createdAtClient?.let {
                            SimpleDateFormat("MM/dd/yy", Locale.US).format(it.toDate())
                        } ?: EMPTY_CELL_VALUE)
                    }
                    MainDocumentFactory.STATION_TAG -> addCellText(defect.stationMarker)
                    MainDocumentFactory.OBSERVATION_NAME_TAG -> addCellText(defect.toMaintenance()?.observationName?.name)
                    MainDocumentFactory.DEFECT_DESCRIPTION_TAG -> addCellText(defect.toStructural()?.defect?.name)
                    MainDocumentFactory.SIZE_TAG -> when (type) {
                        StructuralType.MAINTENANCE -> addCellText(TEXT_NOT_APPLICABLE)
                        StructuralType.STRUCTURAL -> addCellText(defect.toStructural()?.getSizeWithMeasureUnits(observation))
                    }
                    MainDocumentFactory.IMAGE_TAG -> {
                        alignment = Alignment.CENTER
                        createDefectPhotoGalleryUrl(server, defect, inspection, inspector)?.let { url: String ->
                            iconLink(url, drawableRes = "icon_images_report.png", size = IMAGES_LING_SIZE)
                        }

                        alignment = Alignment.CENTER
                    }
                    MainDocumentFactory.CORRECTIVE_ACTION_TAG -> {
                        alignment = Alignment.CENTER
                        addCellText(defect.observationType?.letter())
                    }
                    MainDocumentFactory.CS_TAG -> {
                        alignment = Alignment.CENTER
                        when (type) {
                            StructuralType.MAINTENANCE -> addCellText(TEXT_NOT_APPLICABLE)
                            StructuralType.STRUCTURAL -> addCellText(convertCsRating(defect.toStructural()?.condition?.type))
                        }
                    }
                    MainDocumentFactory.REPAIR_TAG -> {
                        alignment = Alignment.CENTER
                        addCellText(defect.repairMethod)
                    }
                    MainDocumentFactory.REPAIR_DATE_TAG -> {
                        alignment = Alignment.CENTER
                        addCellText(defect.repairDate)
                    }
                    MainDocumentFactory.CRITICAL_FINDING_TAG -> {
                        alignment = Alignment.CENTER
                        addCellText(defect.criticalFindings?.joinToString(",\n") { it.name.toLowerCase().capitalize() })
                    }
                    MainDocumentFactory.PREV_DEF_ID_TAG -> {
                        alignment = Alignment.CENTER
                        addCellText(defect.previousDefectNumber)
                    }
                    MainDocumentFactory.PREV_OBSERVATION_ID_TAG -> {
                        alignment = Alignment.CENTER
                        addCellText(defect.previousDefectNumber)
                    }
                    MainDocumentFactory.O_CLOCK_POSITION_TAG -> {
                        alignment = Alignment.CENTER
                        addCellText(if (defect.clockPosition == null) null else  defect.clockPosition.toString(), TEXT_NOT_APPLICABLE)
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