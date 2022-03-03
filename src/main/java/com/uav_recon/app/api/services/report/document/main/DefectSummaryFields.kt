package com.uav_recon.app.api.services.report.document.main

import com.uav_recon.app.api.entities.db.ConditionType
import com.uav_recon.app.api.entities.db.Observation
import com.uav_recon.app.api.services.ObservationService
import com.uav_recon.app.api.services.report.ReportConstants
import com.uav_recon.app.api.services.report.document.models.body.Table
import com.uav_recon.app.api.services.report.document.models.elements.TextElement
import kotlin.math.roundToInt

internal class DefectSummaryFields(private val flavor: String = "default") {

    private val fields = ArrayList<DefectSummaryField>()

    init {
        addField("sub_component", ReportConstants.COLOR_GRAY_BLUE, 0.25f, SUB_COMPONENT_TAG)
        addField("total_quantity", ReportConstants.COLOR_GRAY_BLUE, 0.25f, TOTAL_QUANTITY_TAG)
        addField("unit", ReportConstants.COLOR_GRAY_BLUE, 0.0715f, UNIT_TAG)
        addField("cs1", ReportConstants.COLOR_DARK_GREEN, 0.0715f, CS_1_TAG)
        addField("cs2", ReportConstants.COLOR_YELLOW, 0.0715f, CS_2_TAG)
        addField("cs3", ReportConstants.COLOR_ORANGE, 0.0715f, CS_3_TAG)
        addField("cs4", ReportConstants.COLOR_RED, 0.0715f, CS_4_TAG)
        addField("hi", ReportConstants.COLOR_GRAY, 0.0715f, HI_TAG)
    }

    private fun addField(stringId: String, cellColor: String? = null, widthPercent: Float, tag: String) {
        fields.add(DefectSummaryField(TextElement.Simple(CustomReportManager.getInstance().getString(stringId, flavor), styles = MainDocumentFactory.BOLD_STYLE_LIST), cellColor, widthPercent, tag, flavor))
    }

    private fun createCell(width: Int, text: TextElement, cellColor: String? = null) =
            Table.Row.Cell.create {
                width {
                    width
                }
                cellColor?.let { color ->
                    color { color }
                }
                paragraph {
                    element { text }
                }
            }

    fun buildHeaderRows(tableBuilder: Table.Builder, componentName: String, healthIndex: Double) {
        tableBuilder.apply {
            val headerCells = fields.map { createCell(it.cellWidth, it.textElement, it.cellColor) }
            row {
                cells {
                    return@cells headerCells.mapIndexed { index, cell ->
                        if (index == ReportConstants.MERGE_RANGE.first) {
                            createCell(
                                    cell.width ?: 0,

                                    TextElement.Simple(
                                            if (CustomReportManager.getInstance().isVisible("percentage_scale", flavor))
                                                "$componentName (%.3f)".format(healthIndex) else "$componentName  (%.0f)".format(percentageToScale(healthIndex)),
                                            styles = MainDocumentFactory.BOLD_STYLE_LIST
                                    ),
                                    cellColor = ReportConstants.COLOR_GRAY
                            )
                        } else {
                            cell
                        }
                    }
                }
            }
            row {
                cells { headerCells }
            }
            merge(
                    direction = Table.Merge.Direction.HORIZONTAL,
                    mainAxisIndex = 0,
                    startAxisIndex = ReportConstants.MERGE_RANGE.first,
                    endAxisIndex = ReportConstants.MERGE_RANGE.last
            )
        }
    }

    fun buildCells(rowBuilder: Table.Row.Builder, data: ObservationData) {
        rowBuilder.apply {
            fields.forEach { field ->
                cell {
                    width { field.cellWidth }
                    paragraph {
                        text(field.getValue(data), textSize = SMALL_TABLE_TEXT_SIZE)
                    }
                }
            }
        }
    }

    class DefectSummaryField(val textElement: TextElement.Simple, val cellColor: String? = null, private val widthPercent: Float, private val tag: String, private val flavor: String) {

        fun getValue(observation: ObservationData): String {
            return when (tag) {
                SUB_COMPONENT_TAG -> observation.subComponentName
                TOTAL_QUANTITY_TAG -> observation.totalQuantity.toString()
                UNIT_TAG -> observation.measureUnits
                CS_1_TAG -> observation.cs1.toString()
                CS_2_TAG -> observation.cs2.toString()
                CS_3_TAG -> observation.cs3.toString()
                CS_4_TAG -> observation.cs4.toString()
                HI_TAG -> if (CustomReportManager.getInstance().isVisible("percentage_scale", flavor))
                    "%.3f".format(observation.healthIndex) else "%.0f".format(percentageToScale(observation.healthIndex))
                else -> ""
            } ?: EMPTY_CELL_VALUE
        }

        val cellWidth: Int
            get() = (TABLE_WIDTH_PORTRAIT * widthPercent).roundToInt()
    }

    companion object {
        const val SUB_COMPONENT_TAG = "SUB_COMPONENT_TAG"
        const val TOTAL_QUANTITY_TAG = "TOTAL_QUANTITY_TAG"
        const val UNIT_TAG = "UNIT_TAG"
        const val CS_1_TAG = "CS_1_TAG"
        const val CS_2_TAG = "CS_2_TAG"
        const val CS_3_TAG = "CS_3_TAG"
        const val CS_4_TAG = "CS_4_TAG"
        const val HI_TAG = "HI_TAG"

        fun percentageToScale(f: Double): Double {
            return when {
                f > 0.80 -> {
                    1.0
                }
                f > 0.60 -> {
                    2.0
                }
                f > 0.40 -> {
                    3.0
                }
                f > 0.20 -> {
                    4.0
                }
                else -> {
                    5.0
                }
            }
        }
    }

    data class ObservationData(
            val subComponentId: String?,
            val subComponentName: String?,
            val totalQuantity: Int,
            val measureUnits: String?,
            val cs1: Int,
            val cs2: Int,
            val cs3: Int,
            val cs4: Int,
            val weight: Int,
            val healthIndex: Double
    ) {

        constructor(
                observation: Observation,
                spansCount: Int,
                observationService: ObservationService
        ) : this(
                observation.subcomponent?.id,
                observation.subcomponent?.name,
                observationService.getTotalQuantity(observation, spansCount),
                observation.subcomponent?.measureUnit,
                observationService.getCsValue(observation, ConditionType.GOOD, spansCount),
                observationService.getCsValue(observation, ConditionType.FAIR, spansCount),
                observationService.getCsValue(observation, ConditionType.POOR, spansCount),
                observationService.getCsValue(observation, ConditionType.SEVERE, spansCount),
                observation.subcomponent?.fdotBhiValue ?: 1,
                observationService.getHealthIndex(observation, spansCount)
        )
    }
}
