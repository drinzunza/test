package com.uav_recon.app.api.services.report.document.main

import com.uav_recon.app.api.entities.db.ConditionType
import com.uav_recon.app.api.entities.db.Observation
import com.uav_recon.app.api.services.ObservationService
import com.uav_recon.app.api.services.report.ReportConstants
import com.uav_recon.app.api.services.report.document.models.body.Table
import com.uav_recon.app.api.services.report.document.models.elements.TextElement
import kotlin.math.roundToInt

internal enum class DefectSummaryFields(
        val textElement: TextElement.Simple,
        val cellColor: String? = null,
        private val widthPercent: Float
) {

    SUB_COMPONENT(
        TextElement.Simple("Sub-Component", styles = MainDocumentFactory.BOLD_STYLE_LIST),
        cellColor = ReportConstants.COLOR_GRAY_BLUE,
        widthPercent = 0.25f
    ),
    QTY(
        TextElement.Simple("Total Quantity", styles = MainDocumentFactory.BOLD_STYLE_LIST),
        cellColor = ReportConstants.COLOR_GRAY_BLUE,
        widthPercent = 0.25f
    ),
    UNIT(
        TextElement.Simple("Unit", styles = MainDocumentFactory.BOLD_STYLE_LIST),
        cellColor = ReportConstants.COLOR_GRAY_BLUE,
        widthPercent = 0.0715f
    ),
    CS1(
        TextElement.Simple("CS-1", styles = MainDocumentFactory.BOLD_STYLE_LIST),
        cellColor = ReportConstants.COLOR_DARK_GREEN,
        widthPercent = 0.0715f
    ),
    CS2(
        TextElement.Simple("CS-2", styles = MainDocumentFactory.BOLD_STYLE_LIST),
        cellColor = ReportConstants.COLOR_YELLOW,
        widthPercent = 0.0715f
    ),
    CS3(
        TextElement.Simple("CS-3", styles = MainDocumentFactory.BOLD_STYLE_LIST),
        cellColor = ReportConstants.COLOR_ORANGE,
        widthPercent = 0.0715f
    ),
    CS4(
        TextElement.Simple("CS-4", styles = MainDocumentFactory.BOLD_STYLE_LIST),
        cellColor = ReportConstants.COLOR_RED,
        widthPercent = 0.0715f
    ),
    HEALTH_INDEX(
        TextElement.Simple("HI", styles = MainDocumentFactory.BOLD_STYLE_LIST),
        cellColor = ReportConstants.COLOR_GRAY,
        widthPercent = 0.0715f
    );

    fun getValue(observation: ObservationData): String {
        return when (this) {
            SUB_COMPONENT -> observation.subComponentName
            QTY -> observation.totalQuantity.toString()
            UNIT -> observation.measureUnits
            CS1 -> observation.cs1.toString()
            CS2 -> observation.cs2.toString()
            CS3 -> observation.cs3.toString()
            CS4 -> observation.cs4.toString()
            HEALTH_INDEX -> "%.3f".format(observation.healthIndex)
        } ?: EMPTY_CELL_VALUE
    }

    val cellWidth: Int
        get() = (TABLE_WIDTH_PORTRAIT * widthPercent).roundToInt()

    companion object {

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
                val headerCells = values().map { createCell(it.cellWidth, it.textElement, it.cellColor) }
                row {
                    cells {
                        return@cells headerCells.mapIndexed { index, cell ->
                            if (index == ReportConstants.MERGE_RANGE.first) {
                                createCell(
                                    cell.width ?: 0,
                                    TextElement.Simple(
                                        "$componentName (HI = %.3f)".format(healthIndex),
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
                values().forEach { field ->
                    cell {
                        width { field.cellWidth }
                        paragraph {
                            text(field.getValue(data), textSize = SMALL_TABLE_TEXT_SIZE)
                        }
                    }
                }
            }
        }

    }

    data class ObservationData(
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