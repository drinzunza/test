package com.uav_recon.app.api.services.report.document.main

import com.uav_recon.app.api.entities.db.ConditionType
import com.uav_recon.app.api.entities.db.Observation
import com.uav_recon.app.api.services.ObservationService
import com.uav_recon.app.api.services.report.ReportConstants
import com.uav_recon.app.api.services.report.document.models.body.Table
import com.uav_recon.app.api.services.report.document.models.elements.TextElement
import kotlin.math.roundToInt

internal class DefectSummaryFields(
        val textElement: TextElement.Simple,
        val cellColor: String? = null,
        private val widthPercent: Float
) {



    val cellWidth: Int
        get() = (TABLE_WIDTH_PORTRAIT * widthPercent).roundToInt()

    companion object {

        fun getValue(observation: ObservationData, fieldTag: String, flavor: String): String {
            return when (fieldTag) {
                MainDocumentFactory.SUB_COMPONENT_TAG -> observation.subComponentName
                MainDocumentFactory.TOTAL_QUANTITY_TAG -> observation.totalQuantity.toString()
                MainDocumentFactory.UNIT_TAG -> observation.measureUnits
                MainDocumentFactory.CS_1_TAG -> observation.cs1.toString()
                MainDocumentFactory.CS_2_TAG -> observation.cs2.toString()
                MainDocumentFactory.CS_3_TAG -> observation.cs3.toString()
                MainDocumentFactory.CS_4_TAG -> observation.cs4.toString()
                MainDocumentFactory.HI_TAG -> if(!CustomReportManager.getInstance().isVisible("percentage_scale", flavor))
                    "%.3f".format(observation.healthIndex) else "%.3f".format(percentageToScale(observation.healthIndex))
                else -> ""
            } ?: EMPTY_CELL_VALUE
        }

        private fun getCellWidth (widthPercent: Float) : Int{
            return (TABLE_WIDTH_PORTRAIT * widthPercent).roundToInt()
        }

        fun percentageToScale(f: Double): Double{
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

        fun buildHeaderRows(tableBuilder: Table.Builder, componentName: String, healthIndex: Double, fields: ArrayList<List<Any>>, flavor: String) {
            tableBuilder.apply {
                val headerCells = fields.map { createCell(getCellWidth(it[2] as Float), it[0] as TextElement, it[1] as String) }
                row {
                    cells {
                        return@cells headerCells.mapIndexed { index, cell ->
                            if (index == ReportConstants.MERGE_RANGE.first) {
                                createCell(
                                    cell.width ?: 0,
                                    TextElement.Simple(
                                        "$componentName (${CustomReportManager.getInstance().getString("hi", flavor)} = %.3f)".format(healthIndex),
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

        fun buildCells(rowBuilder: Table.Row.Builder, data: ObservationData, fields: ArrayList<List<Any>>, flavor: String) {
            rowBuilder.apply {
                fields.forEach { field ->
                    cell {
                        width { getCellWidth(field[2] as Float) }
                        paragraph {
                            text(getValue(data, field[3] as String, flavor), textSize = SMALL_TABLE_TEXT_SIZE)
                        }
                    }
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
                observationService.getHealthIndex(observation, spansCount)
        )
    }
}