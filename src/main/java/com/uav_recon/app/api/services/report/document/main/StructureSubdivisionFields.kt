package com.uav_recon.app.api.services.report.document.main

import com.uav_recon.app.api.entities.db.Inspection
import com.uav_recon.app.api.entities.db.StructureSubdivision
import com.uav_recon.app.api.services.report.document.models.body.Alignment
import com.uav_recon.app.api.services.report.document.models.body.Paragraph
import com.uav_recon.app.api.services.report.document.models.body.Table
import com.uav_recon.app.api.services.report.document.models.elements.LineFeedElement
import com.uav_recon.app.api.services.report.document.models.elements.TextElement
import kotlin.math.roundToInt

internal class StructureSubdivisionFields {

    private val fields = ArrayList<StructureSubdivisionField>()

    init {
        addField("number", 0.25f, NUMBER_TAG)
        addField("name", 0.25f, NAME_TAG)
        addField("sub_components", 0.25f, SUB_COMPONENTS_TAG)
        addField("sgr_rating", 0.25f, SGR_RATING_TAG)
    }

    private fun addField(stringId: String, widthPercent: Float, tag: String) {
        fields.add(StructureSubdivisionField(
            TextElement.Simple(
                CustomReportManager.getInstance().getString(stringId, "default"),
                styles = MainDocumentFactory.BOLD_STYLE_LIST,
                textSize = SMALL_TABLE_TEXT_SIZE
            ),
            widthPercent,
            tag
        ))
    }

    class StructureSubdivisionField(
        val textElement: TextElement.Simple,
        private val widthPercent: Float,
        val tag: String
        ) {

        fun getCellWidth(rowWidth: Int?): Int? = rowWidth?.toFloat()?.times(widthPercent)?.roundToInt()
    }

    fun buildHeaderRow(tableBuilder: Table.Builder) {
        tableBuilder.apply {
            val tableWidth = width
            row {
                fields.forEach { field: StructureSubdivisionField ->
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

    fun buildRows(tableBuilder: Table.Builder, inspection: Inspection) {
        tableBuilder.apply {
            inspection.structureSubdivisions?.forEach {
                row {
                    fields.forEach { field ->
                        cell {
                            width = field.getCellWidth(this.width)
                            addParagraph(field.tag, inspection, it)
                        }
                    }
                }
            }
        }
    }

    private fun Table.Row.Cell.Builder.addParagraph(
        tag: String,
        inspection: Inspection,
        structureSubdivision: StructureSubdivision
    ) {
        paragraph {
            alignment = Alignment.START
            when (tag) {
                NUMBER_TAG -> addCellText(structureSubdivision.number)
                NAME_TAG -> addCellText(structureSubdivision.name)
                SUB_COMPONENTS_TAG -> {
                    val allocationsSize = structureSubdivision.observationStructureSubdivisions?.size
                    structureSubdivision.observationStructureSubdivisions?.forEachIndexed { index, allocation ->
                        val observation = inspection.observations?.first { it.uuid == allocation.observationId }
                        val subcomponent = observation?.subcomponent

                        addCellText("${subcomponent?.name} ${allocation.dimensionNumber}${subcomponent?.measureUnit} ${allocation.computedHealthIndex}")

                        if (allocationsSize != null) {
                            if (index != allocationsSize - 1) {
                                lineFeed { LineFeedElement.Simple(1) }
                            }
                        } else {
                            lineFeed { LineFeedElement.Simple(1) }
                        }
                    }
                }
                SGR_RATING_TAG -> addCellText(structureSubdivision.computedSgrRating.toString())
                else -> addCellText()
            }
        }
    }

    private fun Paragraph.Builder.addCellText(text: String? = null, emptyValue: String = EMPTY_CELL_VALUE) {
        text(text ?: emptyValue, textSize = SMALL_TABLE_TEXT_SIZE)
    }

    companion object {
        const val NUMBER_TAG = "NUMBER_TAG"
        const val NAME_TAG = "NAME_TAG"
        const val SUB_COMPONENTS_TAG = "SUB_COMPONENTS_TAG"
        const val SGR_RATING_TAG = "SGR_RATING_TAG"
    }
}
