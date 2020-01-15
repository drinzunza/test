package com.uav_recon.app.api.services.report.document.main

import com.uav_recon.app.api.entities.db.*
import com.uav_recon.app.api.repositories.ObservationDefectRepository
import com.uav_recon.app.api.repositories.ObservationRepository
import com.uav_recon.app.api.services.report.ReportConstants
import com.uav_recon.app.api.services.report.document.models.body.Alignment
import com.uav_recon.app.api.services.report.document.models.body.Table
import com.uav_recon.app.api.services.report.document.models.elements.TextElement
import com.uav_recon.app.api.utils.toDate
import java.text.SimpleDateFormat
import java.util.*
import kotlin.math.roundToInt

private const val IMAGES_LING_SIZE = 16.0
private const val TEXT_MAINTENANCE_ITEM = "Maintenance item"

enum class DefectsReportFields(val textElement: TextElement.Simple, private val widthPercent: Float) {
    INDEX(TextElement.Simple("Index", styles = MainDocumentFactory.BOLD_STYLE_LIST, textSize = SMALL_TABLE_TEXT_SIZE), 0.0417f),
    DEFECT_ID(
        TextElement.Simple("Defect ID", styles = MainDocumentFactory.BOLD_STYLE_LIST, textSize = SMALL_TABLE_TEXT_SIZE),
        0.0986f
    ),
    SUB_COMPONENT(
        TextElement.Simple("Sub-Component", styles = MainDocumentFactory.BOLD_STYLE_LIST, textSize = SMALL_TABLE_TEXT_SIZE),
        0.1236f
    ),
    LOCATION_ID(
        TextElement.Simple("Location ID", styles = MainDocumentFactory.BOLD_STYLE_LIST, textSize = SMALL_TABLE_TEXT_SIZE),
        0.0653f
    ),
    PREV_DEF_NO(
        TextElement.Simple("Prev. def. ID", styles = MainDocumentFactory.BOLD_STYLE_LIST, textSize = SMALL_TABLE_TEXT_SIZE),
        0.0417f
    ),
    DATE(TextElement.Simple("Inspect. Date", styles = MainDocumentFactory.BOLD_STYLE_LIST, textSize = SMALL_TABLE_TEXT_SIZE), 0.0653f),
    STATION(TextElement.Simple("Station", styles = MainDocumentFactory.BOLD_STYLE_LIST, textSize = SMALL_TABLE_TEXT_SIZE), 0.0764f),
    DESCRIPTION(
        TextElement.Simple(
            "Defect Description",
            styles = MainDocumentFactory.BOLD_STYLE_LIST,
            textSize = SMALL_TABLE_TEXT_SIZE
        ), 0.1194f
    ),
    SIZE(TextElement.Simple("Size", styles = MainDocumentFactory.BOLD_STYLE_LIST, textSize = SMALL_TABLE_TEXT_SIZE), 0.0458f),
    IMAGE(TextElement.Simple("Image", styles = MainDocumentFactory.BOLD_STYLE_LIST, textSize = SMALL_TABLE_TEXT_SIZE), 0.0375f),
    CS_RATING(TextElement.Simple("CS", styles = MainDocumentFactory.BOLD_STYLE_LIST, textSize = SMALL_TABLE_TEXT_SIZE), 0.0361f),
    STATUS(TextElement.Simple("Status", styles = MainDocumentFactory.BOLD_STYLE_LIST, textSize = SMALL_TABLE_TEXT_SIZE), 0.05f),
    CORR_ACTION(
        TextElement.Simple("Corr. Action", styles = MainDocumentFactory.BOLD_STYLE_LIST, textSize = SMALL_TABLE_TEXT_SIZE),
        0.0458f
    ),
    REPAIR_SCHEDULE(
        TextElement.Simple(
            "Repair Schedule",
            styles = MainDocumentFactory.BOLD_STYLE_LIST,
            textSize = SMALL_TABLE_TEXT_SIZE
        ), 0.1514f
    );

    val cellWidth: Int
        get() = (TABLE_WIDTH_LANDSCAPE * widthPercent).roundToInt()

    companion object {

        fun buildHeaderRows(tableBuilder: Table.Builder) {
            tableBuilder.apply {
                row {
                    cells { values().map { createCell(it.cellWidth, it.textElement) } }
                }
            }
        }

        private fun createCell(width: Int, text: TextElement, cellColor: String? = null, hAlignment: Alignment = Alignment.START) =
            Table.Row.Cell.create {
                width {
                    width
                }
                paragraph {
                    alignment = hAlignment
                    element { text }
                }
                cellColor?.let { color ->
                    color { color }
                }
            }

        private fun createDefectPhotoGalleryUrl(
                server: String, defect: ObservationDefect,
                inspection: Inspection, inspector: User,
                observationRepository: ObservationRepository,
                observationDefectRepository: ObservationDefectRepository
        ): String? {
            val inspectorId = inspector.id ?: return null
            val inspectionId = inspection.uuid

            val observationId = observationRepository.findAllByInspectionIdAndDeletedIsFalse(inspection.uuid).firstOrNull {
                val defects = observationDefectRepository.findAllByObservationIdAndDeletedIsFalse(it.uuid)
                var containsById = false
                defects.forEach { d ->
                    if (d.id == defect.id)
                        containsById = true
                }
                containsById
            }?.id

            return "$server/datarecon/$inspectorId/$inspectionId/$observationId/${defect.id}"
        }

        private fun getComponentName(showSubComponent: Boolean, observation: Observation): String? =
            if (showSubComponent) {
                observation.subcomponent?.name?.let { if (it.toLowerCase() != "n/a") it else observation.structuralComponent?.name }
            } else null

        private fun getSizeWithMeasureUnits(defect: ObservationDefect, observation: Observation): String? {
            val structuralDefect = if (defect.type == StructuralType.STRUCTURAL) defect else null
            return structuralDefect?.size?.let { size ->
                observation.subcomponent?.measureUnit?.let { unit ->
                    "$size $unit"
                } ?: size
            }
        }

        private fun convertCsRating(conditionType: ConditionType?): String = when (conditionType) {
            ConditionType.GOOD -> "1"
            ConditionType.FAIR -> "2"
            ConditionType.POOR -> "3"
            ConditionType.SEVERE -> "4"
            else -> EMPTY_CELL_VALUE
        }

        fun buildRows(builder: Table.Builder,
                      inspection: Inspection, inspector: User,
                      type: StructuralType, server: String,
                      observationRepository: ObservationRepository,
                      observationDefectRepository: ObservationDefectRepository) {
            builder.apply {
                fillRow(inspection, inspector, type, server, observationRepository, observationDefectRepository)
            }
        }

        private fun ObservationDefect.getWeatherText(): String? {
            return if (temperature != null) "T $temperature℉ Hum $humidity% Wind $wind m/h" else null
        }

        private fun Table.Builder.fillRow(
                inspection: Inspection, inspector: User,
                type: StructuralType, server: String,
                observationRepository: ObservationRepository,
                observationDefectRepository: ObservationDefectRepository
        ) {
            var i = 0
            var observationIndex = 0
            observationRepository.findAllByInspectionIdAndDeletedIsFalse(inspection.uuid).forEach { observation ->
                var haveDefectsToShow = true
                observationDefectRepository.findAllByObservationIdAndDeletedIsFalse(observation.uuid)
                    .filter { type == it.type }
                    .ifEmpty {
                        haveDefectsToShow = false
                        listOf()
                    }
                    .forEachIndexed { defectIndex, defect ->
                        row {
                            values().forEach {
                                cell {
                                    width { it.cellWidth }
                                    if (observationIndex % 2 == 0) {
                                        color = ReportConstants.COLOR_GRAY
                                    }
                                    paragraph {
                                        alignment = Alignment.START
                                        val buildText: (String?) -> Unit = {
                                            text(it ?: EMPTY_CELL_VALUE, textSize = SMALL_TABLE_TEXT_SIZE)
                                        }
                                        val buildEmptyText: () -> Unit = {
                                            buildText(null)
                                        }
                                        when (it) {
                                            INDEX -> buildText((i + 1).toString())
                                            DEFECT_ID -> buildText(defect.id)
                                            SUB_COMPONENT -> buildText(getComponentName(defectIndex == 0, observation))
                                            LOCATION_ID -> buildText(defect.span ?: TEXT_NOT_APPLICABLE)
                                            DATE -> buildText(inspection.endDate?.let { SimpleDateFormat("MM/dd/yy", Locale.US).format(it.toDate()) }
                                                ?: EMPTY_CELL_VALUE)
                                            STATION -> buildText(defect.stationMarker ?: EMPTY_CELL_VALUE)
                                            DESCRIPTION -> when (type) {
                                                StructuralType.MAINTENANCE -> buildText(TEXT_MAINTENANCE_ITEM)
                                                StructuralType.STRUCTURAL -> buildText(defect.defect?.name)
                                            }
                                            SIZE -> when (type) {
                                                StructuralType.MAINTENANCE -> buildText(TEXT_NOT_APPLICABLE)
                                                StructuralType.STRUCTURAL -> buildText(getSizeWithMeasureUnits(defect, observation))
                                            }
                                            IMAGE -> {
                                                iconLink(
                                                    createDefectPhotoGalleryUrl(server, defect, inspection, inspector, observationRepository, observationDefectRepository) ?: "",
                                                    drawableRes = "icon_images_report.png",
                                                    size = IMAGES_LING_SIZE
                                                )
                                                alignment = Alignment.CENTER
                                            }
                                            CS_RATING -> when (type) {
                                                StructuralType.MAINTENANCE -> buildText(TEXT_NOT_APPLICABLE)
                                                StructuralType.STRUCTURAL -> buildText(
                                                    convertCsRating((if (defect.type == StructuralType.STRUCTURAL) defect else null)?.condition?.type
                                                    )
                                                )
                                            }
                                            else -> buildEmptyText()
                                        }
                                    }
                                }
                            }
                        }
                        i++
                    }
                if (haveDefectsToShow) observationIndex++
            }
        }
    }
}