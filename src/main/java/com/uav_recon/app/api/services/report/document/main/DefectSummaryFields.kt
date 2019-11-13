package com.uav_recon.app.api.services.report.document.main

import com.uav_recon.app.api.entities.db.Observation
import com.uav_recon.app.api.entities.db.ObservationDefect
import com.uav_recon.app.api.repositories.ObservationDefectRepository
import com.uav_recon.app.api.services.report.document.models.body.Table
import com.uav_recon.app.api.services.report.document.models.elements.TextElement
import java.text.DecimalFormat

internal enum class DefectSummaryFields(val textElement: TextElement.Simple, val cellColor: String? = null, val cellWidth: Int? = null) {

    SUB_COMPONENT(TextElement.Simple("Sub-Component", styles = MainDocumentFactory.BOLD_STYLE_LIST)),
    DEFECT(TextElement.Simple("Defect ID", styles = MainDocumentFactory.BOLD_STYLE_LIST), cellWidth = 2000),
    DEFECT_NUMBER(TextElement.Simple("Defect number", styles = MainDocumentFactory.BOLD_STYLE_LIST)),
    QTY(TextElement.Simple("QTY", styles = MainDocumentFactory.BOLD_STYLE_LIST)),
    UNIT(TextElement.Simple("Unit", styles = MainDocumentFactory.BOLD_STYLE_LIST)),
    CS1(TextElement.Simple("CS-1", styles = MainDocumentFactory.BOLD_STYLE_LIST), cellColor = "#00b04f"),
    CS2(TextElement.Simple("CS-2", styles = MainDocumentFactory.BOLD_STYLE_LIST), cellColor = "#ffff00"),
    CS3(TextElement.Simple("CS-3", styles = MainDocumentFactory.BOLD_STYLE_LIST), cellColor = "#ffc000"),
    CS4(TextElement.Simple("CS-4", styles = MainDocumentFactory.BOLD_STYLE_LIST), cellColor = "#ff0400"),
    CS5(TextElement.Simple("CS-5", styles = MainDocumentFactory.BOLD_STYLE_LIST), cellColor = "#bfbfbf");

    fun getValue(observation: Observation, defect: ObservationDefect): String {
        return when (this) {
            SUB_COMPONENT -> observation.subcomponent?.name
            DEFECT -> defect.id.toString()
            DEFECT_NUMBER -> defect.defect?.number?.toString()
            QTY -> "1"
            UNIT -> defect.material?.measureUnit
            else -> if (defect.condition?.type == toDefectConditionType()) defect.size else null
        } ?: ""
    }

    fun getTotalValue(observation: Observation, observationDefectRepository: ObservationDefectRepository): String {
        val defects = observationDefectRepository.findAllByObservationId(observation.id)
        return when(this) {
            SUB_COMPONENT -> "Total "
            DEFECT, DEFECT_NUMBER, UNIT -> ""
            QTY -> defects.size.toString()
            else -> {
                val type = toDefectConditionType() ?: return ""
                return DOUBLE_FORMAT.format(defects.filter {
                    it.condition?.type == type && it.size != null
                }.sumByDouble {
                    it.size?.toDoubleOrNull() ?: 0.0
                })
            }
        }
    }

    private fun toDefectConditionType(): String? {
        return when(this) {
            CS1 -> "GOOD"
            CS2 -> "FAIR"
            CS3 -> "POOR"
            CS4 -> "SEVERE"
            CS5 -> "OTHER"
            else -> null
        }
    }

    companion object {

        private val DOUBLE_FORMAT = DecimalFormat("###.#########")

        val CELL_LIST: List<Table.Row.Cell> = convertToRowCells()

        private fun convertToRowCells(): List<Table.Row.Cell> {
            val list = mutableListOf<Table.Row.Cell>()
            values().forEach {
                val cell = Table.Row.Cell.create {
                    it.cellWidth?.let { width ->
                        width { width }
                    }
                    it.cellColor?.let { color ->
                        color { color }
                    }
                    paragraph {
                        element { it.textElement }
                    }
                }
                list.add(cell)
            }
            return list
        }

    }

}
