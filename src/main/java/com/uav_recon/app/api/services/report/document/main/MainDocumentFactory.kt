package com.uav_recon.app.api.services.report.document.main

import com.uav_recon.app.api.entities.db.Inspection
import com.uav_recon.app.api.entities.db.Observation
import com.uav_recon.app.api.entities.db.ObservationDefect
import com.uav_recon.app.api.entities.db.Report
import com.uav_recon.app.api.repositories.ObservationDefectRepository
import com.uav_recon.app.api.repositories.ObservationRepository
import com.uav_recon.app.api.repositories.PhotoRepository
import com.uav_recon.app.api.services.FileStorageService
import com.uav_recon.app.api.services.report.MapLoaderService
import com.uav_recon.app.api.services.report.document.DocumentFactory
import com.uav_recon.app.api.services.report.document.models.Document
import com.uav_recon.app.api.services.report.document.models.Page
import com.uav_recon.app.api.services.report.document.models.body.Paragraph
import com.uav_recon.app.api.services.report.document.models.body.Paragraph.Alignment.RIGHT
import com.uav_recon.app.api.services.report.document.models.body.Table
import com.uav_recon.app.api.services.report.document.models.body.Table.Row
import com.uav_recon.app.api.services.report.document.models.elements.Element
import com.uav_recon.app.api.services.report.document.models.elements.LineFeedElement
import com.uav_recon.app.api.services.report.document.models.elements.TextElement
import com.uav_recon.app.api.services.report.document.models.elements.TextElement.Typeface.BOLD
import com.uav_recon.app.api.services.report.document.models.elements.TextElement.Typeface.ITALIC
import com.uav_recon.app.api.utils.formatDate
import org.springframework.stereotype.Service
import java.text.SimpleDateFormat
import java.util.*

private const val BORDER_SIZE = 2
private const val BORDER_SPACE = 24

private const val SMALL_TEXT_SIZE = 9

private const val PICTURE_SPACE_CELL_WIDTH = 500
private const val PICTURE_STREAM_SIZE = 720
private const val MAP_PICTURE_WIDTH = 450
private const val MAP_PICTURE_HEIGHT = 250
private const val DEFECT_PHOTO_SIZE = 160
private const val TABLE_WIDTH = 9350
private const val PAGE_WIDTH = (8.5 * 1440).toInt()
private const val PAGE_HEIGHT = (11 * 1440)

@Service
class MainDocumentFactory(
        private val mapLoaderService: MapLoaderService,
        private val observationRepository: ObservationRepository,
        private val observationDefectRepository: ObservationDefectRepository,
        private val photoRepository: PhotoRepository,
        private val fileStorageService: FileStorageService
) : DocumentFactory {

    companion object {
        internal val DATE_FORMAT = SimpleDateFormat("MM/dd/yyyy", Locale.US)
        private const val FORMAT_KEY_VALUE = "%s: %s"

        private const val PERCENT = "%"
        private const val SGR_RATING = "SGR Rating"
        private const val TERM_RATING = "Term Rating"
        private const val INSPECTED_BY_FORMAT = "Inspected by: %s (User id: %s)"

        private const val LOCATION_DESCRIPTION = "Location description: "
        private const val DEFECT_DESCRIPTION = "Defect description: "

        private val BORDER: Document.Border = Document.Border.Simple(BORDER_SIZE, BORDER_SPACE, "#000000")
        internal val BOLD_STYLE_LIST = listOf(BOLD)
        internal val ITALIC_STYLE_LIST = listOf(ITALIC)
        internal val ITALIC_BOLD_STYLE_LIST = listOf(ITALIC, BOLD)

        private val SINGLE_LINE_FEED_ELEMENT = LineFeedElement.Simple(1)
        private val DOUBLE_LINE_FEED_ELEMENT = LineFeedElement.Simple(2)
        private val TRIPLE_LINE_FEED_ELEMENT = LineFeedElement.Simple(3)

        private val STRUCTURE_TYPE_ELEMENT = TextElement.Simple("Structure Type: ", styles = BOLD_STYLE_LIST)
        private val STRUCTURE_ID_ELEMENT = TextElement.Simple("Structure ID: ", styles = BOLD_STYLE_LIST)
        private val CALTRANS_NO_ELEMENT = TextElement.Simple("Caltrans Bridge No.", styles = BOLD_STYLE_LIST)
        private val POST_MILE_ELEMENT = TextElement.Simple("Post Mile: ", styles = BOLD_STYLE_LIST)
        private val STATIONING_ELEMENT = TextElement.Simple("Stationing", styles = BOLD_STYLE_LIST)
        private val PRIMARY_OWNER_ELEMENT =
            TextElement.Simple("Primary Owner: ", textSize = SMALL_TEXT_SIZE, styles = ITALIC_BOLD_STYLE_LIST)
        private val STRUCTURE_NAME_ELEMENT =
            TextElement.Simple("Structure Name: ", textSize = SMALL_TEXT_SIZE, styles = ITALIC_BOLD_STYLE_LIST)
        private val REPORT_PREPARED_ELEMENT = TextElement.Simple("Inspection Report Prepared ", styles = BOLD_STYLE_LIST)
        private val BY_ELEMENT = TextElement.Simple("by: ", styles = BOLD_STYLE_LIST)
        private val REPORT_NO_ELEMENT = TextElement.Simple("Inspection Report No.: ")
        private val REPORT_DATE_ELEMENT = TextElement.Simple("Report Date: ")
        private val INSPECTION_DATE_ELEMENT = TextElement.Simple("Inspection Date(s): ")
        private val WEATHER_ELEMENT = TextElement.Simple("Weather: ")

        private val CRITICAL_FINDINGS_ELEMENT =
            TextElement.Simple("Critical Findings – Prompt Action Required", styles = ITALIC_BOLD_STYLE_LIST)
        private val STRUCTURE_CONDITION_CODE_ELEMENT =
            TextElement.Simple("General Structure Condition Code", styles = ITALIC_BOLD_STYLE_LIST)
        private val GENERAL_INSPECTION_ELEMENT = TextElement.Simple("General Inspection Summary", styles = BOLD_STYLE_LIST)

        private val OBSERVATION_SUMMARY_ELEMENT = TextElement.Simple("Summary of Observations by", styles = BOLD_STYLE_LIST)
        private val MAJOR_STRUCTURAL_ELEMENT = TextElement.Simple("Major Structural Component", styles = BOLD_STYLE_LIST)
        private val OBSERVATION_ID_ELEMENT = TextElement.Simple("Observation Id: ", styles = BOLD_STYLE_LIST)

        private val OBSERVATION_REPORT_SUMMARY_ELEMENT = TextElement.Simple("Observation Report Summary", styles = ITALIC_BOLD_STYLE_LIST)
        private val DEFECT_PHOTOS_ELEMENT = TextElement.Simple("Inspection Photographs of Defects", styles = ITALIC_BOLD_STYLE_LIST)

        private val SPACE_ELEMENT = TextElement.Simple("----", textSize = 6, textColor = "#FFFFFF")
        private val PHOTO_SPACE_ELEMENT = TextElement.Simple("    --    ", textColor = "#FFFFFF")
        private val INSPECTOR_SIGNATURE_ELEMENT = TextElement.Simple(
            "Inspector's signature:                                                            Date:                        ",
            styles = ITALIC_STYLE_LIST
        )
    }

    override fun generateDocument(report: Report): Document {
        val inspection = report.inspection!!

        return Document.create {
            border { BORDER }
            pageWidth { PAGE_WIDTH }
            pageHeight { PAGE_HEIGHT }

            page { createTitlePage(report) }
            page { createGlobalPage(inspection) }
            page { createObservationSummary(inspection) }

            observationRepository.findAllByInspectionIdAndDeletedIsFalse(inspection.id).forEach { observation ->
                observationDefectRepository.findAllByObservationIdAndDeletedIsFalse(observation.id).forEach { defect ->
                    page { createDefectReportPage(inspection, observation, defect) }
                }
            }
        }
    }

    private fun Page.Builder.createTitlePage(report: Report) {
        val inspection = report.inspection

        val beginStationing = inspection?.structure?.beginStationing
        val endStationing = inspection?.structure?.endStationing

        val stationing = if (beginStationing != null && endStationing != null) {
            "$beginStationing to $endStationing"
        } else beginStationing ?: endStationing ?: ""

        paragraph {
            createElements(
                TRIPLE_LINE_FEED_ELEMENT,
                STRUCTURE_TYPE_ELEMENT, inspection?.structure?.type
            )
            createElements(
                TRIPLE_LINE_FEED_ELEMENT,
                STRUCTURE_ID_ELEMENT, inspection?.structure?.code
            )
            createElements(prefix = CALTRANS_NO_ELEMENT, text = inspection?.structure?.caltransBridgeNo)
            createElements(prefix = POST_MILE_ELEMENT, text = inspection?.structure?.postmile?.toString())
            createElements(prefix = STATIONING_ELEMENT, text = stationing)
            createElements(
                DOUBLE_LINE_FEED_ELEMENT,
                PRIMARY_OWNER_ELEMENT,
                TextElement.Simple(inspection?.structure?.primaryOwner, textSize = SMALL_TEXT_SIZE)
            )
            createElements(
                DOUBLE_LINE_FEED_ELEMENT,
                STRUCTURE_NAME_ELEMENT,
                TextElement.Simple(inspection?.structure?.name, textSize = SMALL_TEXT_SIZE)
            )
            lineFeed { LineFeedElement.Simple(7) }
            text { REPORT_PREPARED_ELEMENT }
            lineFeed { SINGLE_LINE_FEED_ELEMENT }
            text { BY_ELEMENT }
            text(inspection?.company?.name ?: "")
            lineFeed { LineFeedElement.Simple(4) }
            text { REPORT_NO_ELEMENT }
            text(report.id.toString(), styles = ITALIC_STYLE_LIST)
            lineFeed { SINGLE_LINE_FEED_ELEMENT }
            text { REPORT_DATE_ELEMENT }
            text(formatDate(), styles = ITALIC_STYLE_LIST)
            lineFeed { SINGLE_LINE_FEED_ELEMENT }
            text { INSPECTION_DATE_ELEMENT }
            //text(formatDate(inspection?.startDate), styles = ITALIC_STYLE_LIST)
            lineFeed { SINGLE_LINE_FEED_ELEMENT }
            text { WEATHER_ELEMENT }
            text(inspection?.temperature?.let { "T ${inspection.temperature}F Hum ${inspection.humidity}% Wind ${inspection.wind} m/h" } ?: "", styles = ITALIC_STYLE_LIST)
            lineFeed { SINGLE_LINE_FEED_ELEMENT }
        }
        paragraphLeft {
            lineFeed { LineFeedElement.Simple(9) }
            text {
                val fullName = "${inspection?.inspector?.firstName} ${inspection?.inspector?.lastName}"
                val userId = inspection?.inspector?.id?.toString() ?: ""
                TextElement.Simple(String.format(INSPECTED_BY_FORMAT, fullName, userId), textSize = 8)
            }
        }

    }

    private fun formatDate(date: Date? = Date()): String = date.formatDate(DATE_FORMAT) ?: ""

    private fun Paragraph.Builder.createElements(
            topLineFeed: Element? = SINGLE_LINE_FEED_ELEMENT, prefix: TextElement,
            text: String?, textStyles: List<TextElement.Typeface> = listOf(ITALIC),
            bottomLineFeed: Element? = null
    ) {
        createElements(topLineFeed, prefix, TextElement.Simple(text ?: "", styles = textStyles), bottomLineFeed)
    }

    private fun Paragraph.Builder.createElements(
            topLineFeed: Element? = null,
            prefix: TextElement,
            text: TextElement,
            bottomLineFeed: Element? = null
    ) {
        elements {
            val list = mutableListOf<Element>(prefix, text)
            if (topLineFeed != null) list.add(0, topLineFeed)
            if (bottomLineFeed != null) list.add(bottomLineFeed)
            list
        }
    }

    private fun Page.Builder.createGlobalPage(inspection: Inspection) {
        mapLoaderService.loadImage(inspection)?.let {
            paragraph {
                picture(inputStream = it, width = MAP_PICTURE_WIDTH, height = MAP_PICTURE_HEIGHT)
                lineFeed { DOUBLE_LINE_FEED_ELEMENT }
            }
        }
        table {
            width { TABLE_WIDTH }
            row {
                cell {
                    paragraph {
                        text { CRITICAL_FINDINGS_ELEMENT }
                    }
                }
                cell {
                    paragraph {
                        text { STRUCTURE_CONDITION_CODE_ELEMENT }
                    }
                }
            }
            row {
                cell {
                    paragraph {
                        val values = listOf<String>("Structural", "Safety", "Other")
                        values.forEachIndexed { index, value ->
                            text(formatToValueCount(value, inspection), styles = ITALIC_STYLE_LIST)
                            if (index != values.size - 1) lineFeed { SINGLE_LINE_FEED_ELEMENT }
                        }
                    }

                }
                cell {
                    paragraph {
                        text(formatRating(SGR_RATING, inspection.sgrRating, PERCENT), styles = ITALIC_STYLE_LIST)
                        lineFeed { SINGLE_LINE_FEED_ELEMENT }
                        text(formatRating(TERM_RATING, inspection.termRating), styles = ITALIC_STYLE_LIST)
                    }

                }
            }
        }

        paragraph {
            lineFeed { SINGLE_LINE_FEED_ELEMENT }
        }

        table {
            width { TABLE_WIDTH }
            row {
                cell {
                    paragraph {
                        text { GENERAL_INSPECTION_ELEMENT }
                    }
                }
            }
        }

        paragraphLeft {
            inspection.generalSummary?.split("\n")?.forEach {
                text(it)
                lineFeed { SINGLE_LINE_FEED_ELEMENT }
            }
        }
    }

    private fun formatToValueCount(prefix: String, inspection: Inspection): String {
        val count = observationRepository.findAllByInspectionIdAndDeletedIsFalse(inspection.id).sumBy { observation: Observation ->
            observationDefectRepository.findAllByObservationIdAndDeletedIsFalse(observation.id).sumBy { defect: ObservationDefect ->
                if (defect.criticalFindings?.find { finding -> finding.name.startsWith(prefix) } != null) 1 else 0
            }
        }

        return String.format(FORMAT_KEY_VALUE, prefix, count.toString())
    }

    private fun formatRating(key: String, value: Any?, suffix: String? = null): String {
        return String.format(FORMAT_KEY_VALUE, key, value?.let { it.toString() + (suffix ?: "") } ?: "")
    }

    private fun Page.Builder.createObservationSummary(inspection: Inspection) {
        paragraph {
            text { OBSERVATION_SUMMARY_ELEMENT }
            lineFeed { SINGLE_LINE_FEED_ELEMENT }
            text { MAJOR_STRUCTURAL_ELEMENT }
            lineFeed { DOUBLE_LINE_FEED_ELEMENT }
        }

        observationRepository.findAllByInspectionIdAndDeletedIsFalse(inspection.id).forEach { observation ->
            paragraph {
                text(observation.structuralComponent?.name ?: "", styles = BOLD_STYLE_LIST)
                lineFeed { SINGLE_LINE_FEED_ELEMENT }
                text { OBSERVATION_ID_ELEMENT }
                text(observation.id.toString())
                lineFeed { SINGLE_LINE_FEED_ELEMENT }
            }
            table {
                width { TABLE_WIDTH }
                row {
                    cells { DefectSummaryFields.CELL_LIST }
                }
                generateDefectRows(observation)
            }
            paragraph {
                lineFeed { SINGLE_LINE_FEED_ELEMENT }
            }
        }
    }

    private fun Table.Builder.generateDefectRows(observation: Observation) {
        observationDefectRepository.findAllByObservationIdAndDeletedIsFalse(observation.id).forEach { defect: ObservationDefect ->
            generateDefectRow {
                text(it.getValue(observation, defect))
            }
        }
        // Total
        generateDefectRow {
            if (it == DefectSummaryFields.SUB_COMPONENT) alignment { RIGHT }
            text(it.getTotalValue(observation, observationDefectRepository), styles = BOLD_STYLE_LIST)
        }
    }

    private inline fun Table.Builder.generateDefectRow(paragraphBlock: Paragraph.Builder.(DefectSummaryFields) -> Unit) {
        row {
            DefectSummaryFields.values().forEach { field ->
                cell {
                    field.cellWidth?.let { width -> width { width } }
                    paragraph {
                        paragraphBlock(field)
                    }
                }
            }
        }
    }

    private fun Page.Builder.createDefectReportPage(inspection: Inspection, observation: Observation, defect: ObservationDefect) {
        paragraph {
            text { OBSERVATION_REPORT_SUMMARY_ELEMENT }
        }

        table {
            borders { false }
            width { TABLE_WIDTH }
            row {
                DefectFields.CELLS_ALIGNMENT_MAP.forEach {
                    cell {
                        width { TABLE_WIDTH / 2 }
                        paragraph {
                            alignment { it.key }
                            it.value.forEach { field ->
                                elementsKeyValue(field.title,
                                        field.getValue(inspection, observation, defect, observationDefectRepository, photoRepository), SMALL_TEXT_SIZE)
                            }
                        }
                    }
                }
            }
        }

        paragraphLeft {
            elementsKeyValue(LOCATION_DESCRIPTION, observation.locationDescription, SMALL_TEXT_SIZE)
            elementsKeyValue(DEFECT_DESCRIPTION, defect.description, SMALL_TEXT_SIZE)
        }

        paragraph {
            element { SINGLE_LINE_FEED_ELEMENT }
            element { DEFECT_PHOTOS_ELEMENT }
        }

        table {
            width { (TABLE_WIDTH * 0.8).toInt() }
            borders { false }
            rowsPictures(inspection, defect)
        }

        paragraph {
            lineFeed { SINGLE_LINE_FEED_ELEMENT }
            text { INSPECTOR_SIGNATURE_ELEMENT }
        }
    }

    private fun Table.Builder.rowsPictures(inspection: Inspection, defect: ObservationDefect) {
        val photos = photoRepository.findAllByObservationDefectIdAndDeletedIsFalse(defect.id.toString())
        for (i in 0..(photos.size - 1) / 2) {
            row {
                cell {
                    paragraphPhoto(inspection, defect, i * 2)
                }
                cell {
                    width { PICTURE_SPACE_CELL_WIDTH }
                    paragraphLeft {
                        text { PHOTO_SPACE_ELEMENT }
                        lineFeed { SINGLE_LINE_FEED_ELEMENT }
                    }
                }
                cell {
                    paragraphPhoto(inspection, defect, i * 2 + 1)
                }
            }
        }
    }

    private fun Row.Cell.Builder.paragraphPhoto(inspection: Inspection, defect: ObservationDefect, index: Int) {
        paragraphLeft {
            text { PHOTO_SPACE_ELEMENT }
            lineFeed { SINGLE_LINE_FEED_ELEMENT }
            photoRepository.findAllByObservationDefectIdAndDeletedIsFalse(defect.id.toString()).getOrNull(index)?.let { photo ->
                //val resource = fileStorageService.loadFileAsResource(photo.link!!)
                //picture(photo.file, resource.inputStream, DEFECT_PHOTO_SIZE, DEFECT_PHOTO_SIZE)
                text { SPACE_ELEMENT }
                lineFeed { SINGLE_LINE_FEED_ELEMENT }
                //text(photo.file, textSize = 6)
                lineFeed { SINGLE_LINE_FEED_ELEMENT }
                inspection.inspector?.let {
                    //text { LinkTextElement.Simple(photo.file, textSize = 6) } // TODO add link
                }
            }
        }
    }

    private fun Paragraph.Builder.elementsKeyValue(key: String, value: String?, fontSize: Int? = null) {
        text(key, textSize = fontSize, styles = BOLD_STYLE_LIST)
        text(value, textSize = fontSize)
        lineFeed { SINGLE_LINE_FEED_ELEMENT }
    }
}
