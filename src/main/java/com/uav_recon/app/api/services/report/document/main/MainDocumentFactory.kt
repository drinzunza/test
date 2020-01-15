package com.uav_recon.app.api.services.report.document.main

import com.uav_recon.app.api.beans.resources.Resources
import com.uav_recon.app.api.entities.db.*
import com.uav_recon.app.api.repositories.*
import com.uav_recon.app.api.services.FileService
import com.uav_recon.app.api.services.ObservationService
import com.uav_recon.app.api.services.report.MapLoaderService
import com.uav_recon.app.api.services.report.ReportConstants
import com.uav_recon.app.api.services.report.document.DocumentFactory
import com.uav_recon.app.api.services.report.document.models.Document
import com.uav_recon.app.api.services.report.document.models.Page
import com.uav_recon.app.api.services.report.document.models.body.Paragraph
import com.uav_recon.app.api.services.report.document.models.body.Table
import com.uav_recon.app.api.services.report.document.models.body.Table.Row
import com.uav_recon.app.api.services.report.document.models.elements.Element
import com.uav_recon.app.api.services.report.document.models.elements.LineFeedElement
import com.uav_recon.app.api.services.report.document.models.elements.LinkTextElement
import com.uav_recon.app.api.services.report.document.models.elements.TextElement
import com.uav_recon.app.api.services.report.document.models.elements.TextElement.Typeface.BOLD
import com.uav_recon.app.api.services.report.document.models.elements.TextElement.Typeface.ITALIC
import com.uav_recon.app.api.utils.formatDate
import com.uav_recon.app.configurations.UavConfiguration
import org.slf4j.LoggerFactory
import org.springframework.stereotype.Service
import java.text.DecimalFormat
import java.text.SimpleDateFormat
import java.util.*
import kotlin.math.roundToInt

internal const val EMPTY_CELL_VALUE = ""
internal const val SMALL_TABLE_TEXT_SIZE = 8

private const val BORDER_SIZE = 2
private const val BORDER_SPACE = 24

private const val SMALL_TEXT_SIZE = 9

private const val PICTURE_SPACE_CELL_WIDTH = 500
private const val PICTURE_STREAM_SIZE = 720
private const val MAP_PICTURE_WIDTH = 450
private const val MAP_PICTURE_HEIGHT = 250
private const val DEFECT_PHOTO_SIZE = 160
internal const val TABLE_WIDTH_PORTRAIT = 9350
internal const val TABLE_WIDTH_LANDSCAPE = 13050
internal const val TEXT_NOT_APPLICABLE = "N/A"
private const val LOGO_WIDTH = 190
private val LOGO_HEIGHT = (LOGO_WIDTH * 394.0 / 1773.0).roundToInt()

@Service
class MainDocumentFactory(
        private val mapLoaderService: MapLoaderService,
        private val inspectionRepository: InspectionRepository,
        private val observationService: ObservationService,
        private val observationRepository: ObservationRepository,
        private val observationDefectRepository: ObservationDefectRepository,
        private val structureRepository: StructureRepository,
        private val userRepository: UserRepository,
        private val photoRepository: PhotoRepository,
        private val resources: Resources,
        private val configuration: UavConfiguration,
        private val fileService: FileService
) : DocumentFactory {

    private val logger = LoggerFactory.getLogger(MainDocumentFactory::class.java)

    companion object {
        internal val DATE_FORMAT = SimpleDateFormat("MM/dd/yyyy", Locale.US)
        private const val FORMAT_KEY_VALUE = "%s: %s"

        private const val PERCENT = "%"
        private const val SGR_RATING = "SGR Rating"
        private const val TERM_RATING = "Term Rating"
        private const val INSPECTED_BY_FORMAT = "Inspected by: %s (User id: %s)"

        private const val LOCATION_DESCRIPTION = "Location description: "
        private const val DEFECT_DESCRIPTION = "Defect description: "

        private val BORDER: Document.Border = Document.Border.Simple(BORDER_SIZE, BORDER_SPACE, ReportConstants.COLOR_BLACK)
        internal val BOLD_STYLE_LIST = listOf(BOLD)
        internal val ITALIC_STYLE_LIST = listOf(ITALIC)
        internal val ITALIC_BOLD_STYLE_LIST = listOf(ITALIC, BOLD)

        private val SINGLE_LINE_FEED_ELEMENT = LineFeedElement.Simple(1)
        private val DOUBLE_LINE_FEED_ELEMENT = LineFeedElement.Simple(2)
        private val TRIPLE_LINE_FEED_ELEMENT = LineFeedElement.Simple(3)

        private val STRUCTURE_TYPE_ELEMENT = TextElement.Simple("Structure Type: ", styles = BOLD_STYLE_LIST)
        private val STRUCTURE_ID_ELEMENT = TextElement.Simple("Structure ID: ", styles = BOLD_STYLE_LIST)
        private val CALTRANS_NO_ELEMENT =
            TextElement.Simple("Caltrans Bridge No.: ", textSize = SMALL_TEXT_SIZE, styles = ITALIC_BOLD_STYLE_LIST)
        private val POST_MILE_ELEMENT = TextElement.Simple("Post Mile: ", textSize = SMALL_TEXT_SIZE, styles = ITALIC_BOLD_STYLE_LIST)
        private val STATIONING_ELEMENT = TextElement.Simple("Stationing: ", textSize = SMALL_TEXT_SIZE, styles = ITALIC_BOLD_STYLE_LIST)
        private val PRIMARY_OWNER_ELEMENT =
            TextElement.Simple("Primary Owner: ", styles = BOLD_STYLE_LIST)
        private val STRUCTURE_NAME_ELEMENT =
            TextElement.Simple("Structure Name: ", styles = BOLD_STYLE_LIST)
        private val REPORT_PREPARED_ELEMENT = TextElement.Simple("Inspection Report Prepared by:", styles = BOLD_STYLE_LIST)
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

        private val SPACE_ELEMENT = TextElement.Simple("----", textSize = 6, textColor = ReportConstants.COLOR_WHITE)
        private val PHOTO_SPACE_ELEMENT = TextElement.Simple("    --    ", textColor = ReportConstants.COLOR_WHITE)
        private val INSPECTOR_SIGNATURE_ELEMENT = TextElement.Simple(
            "Inspector's signature:                                                            Date:                        ",
            styles = ITALIC_STYLE_LIST
        )
        private val STRUCTURAL_DEFECTS_REPORT_ELEMENT =
            TextElement.Simple("Field Inspection Report - Structural Defects", styles = BOLD_STYLE_LIST)
        private val NON_STRUCTURAL_DEFECTS_REPORT_ELEMENT =
            TextElement.Simple("Field Inspection Report - Non-structural Defects", styles = BOLD_STYLE_LIST)
    }

    override fun generateDocument(report: Report): Document {
        val inspection = inspectionRepository.findFirstByUuidAndDeletedIsFalse(report.inspectionId)!!
        val structure = inspection.structureId?.let { structureRepository.findFirstById(inspection.structureId!!) }
        val company = Company(1, "Alta Vista Solutions")
        val inspector = userRepository.findFirstById(inspection.updatedBy.toLong())!!

        return Document.create {
            border { BORDER }

            page { createTitlePage(report, inspection, inspector, structure, company) }
            page { createGlobalPage(inspection) }
            page { createStructuralDefectsReport(inspection, inspector) }
            page { createNonStructuralDefectsReport(inspection, inspector) }
            page { createObservationSummary(inspection) }

            observationRepository.findAllByInspectionIdAndDeletedIsFalse(inspection.uuid).forEach { observation ->
                observationDefectRepository.findAllByObservationIdAndDeletedIsFalse(observation.uuid).forEach { defect ->
                    page { createDefectReportPage(inspection, inspector, structure, observation, defect) }
                }
            }
        }
    }

    private fun Page.Builder.createTitlePage(report: Report, inspection: Inspection?, inspector: User?, structure: Structure?, company: Company?) {
        paragraph {
            createElements(
                TRIPLE_LINE_FEED_ELEMENT,
                STRUCTURE_TYPE_ELEMENT, structure?.type ?: ""
            )
            createElements(prefix = STRUCTURE_ID_ELEMENT, text = structure?.id)
            createElements(prefix = STRUCTURE_NAME_ELEMENT, text = structure?.name)
            createElements(prefix = PRIMARY_OWNER_ELEMENT, text = structure?.primaryOwner)
            lineFeed { LineFeedElement.Simple(1) }
            createElements(
                prefix = CALTRANS_NO_ELEMENT,
                text = structure?.caltransBridgeNo,
                textStyles = listOf(),
                textSize = SMALL_TEXT_SIZE
            )
            createElements(
                prefix = POST_MILE_ELEMENT,
                text = structure?.postmile?.toString(),
                textStyles = listOf(),
                textSize = SMALL_TEXT_SIZE
            )
            createElements(prefix = STATIONING_ELEMENT, text = inspection?.getStationing(structure) ?: "", textStyles = listOf(), textSize = SMALL_TEXT_SIZE)
            lineFeed { LineFeedElement.Simple(7) }
            text { REPORT_PREPARED_ELEMENT }
            lineFeed { SINGLE_LINE_FEED_ELEMENT }
            picture(
                company?.name ?: "",
                resources.getData("logo_altavista.png")!!.inputStream(),
                LOGO_WIDTH,
                LOGO_HEIGHT
            )
            lineFeed { LineFeedElement.Simple(4) }
            text { REPORT_NO_ELEMENT }
            text(report.id, styles = ITALIC_STYLE_LIST)
            lineFeed { SINGLE_LINE_FEED_ELEMENT }
            text { REPORT_DATE_ELEMENT }
            text(formatDate(), styles = ITALIC_STYLE_LIST)
            lineFeed { SINGLE_LINE_FEED_ELEMENT }
            text { INSPECTION_DATE_ELEMENT }
            text(formatDate(Date(inspection?.startDate?.toEpochSecond() ?: Date().time)), styles = ITALIC_STYLE_LIST)
            lineFeed { SINGLE_LINE_FEED_ELEMENT }
            text { WEATHER_ELEMENT }
            text(inspection?.getWeatherText() ?: "", styles = ITALIC_STYLE_LIST)
            lineFeed { SINGLE_LINE_FEED_ELEMENT }
        }
        paragraphLeft {
            lineFeed { LineFeedElement.Simple(9) }
            text {
                val fullName = if (inspector != null) "${inspector.firstName} ${inspector.lastName}" else ""
                val userId = inspector?.id ?: ""
                TextElement.Simple(String.format(INSPECTED_BY_FORMAT, fullName, userId), textSize = 8)
            }
        }
    }

    private fun formatDate(date: Date? = Date()): String = date.formatDate(DATE_FORMAT) ?: ""

    private fun Paragraph.Builder.createElements(
            topLineFeed: Element? = SINGLE_LINE_FEED_ELEMENT, prefix: TextElement,
            text: String?,
            textStyles: List<TextElement.Typeface> = listOf(ITALIC),
            textSize: Int? = null,
            bottomLineFeed: Element? = null
    ) {
        createElements(topLineFeed, prefix, TextElement.Simple(text ?: "", styles = textStyles, textSize = textSize), bottomLineFeed)
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
            width { TABLE_WIDTH_PORTRAIT }
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
                        val values = CriticalFinding.values()
                        values.forEachIndexed { index, value ->
                            text(value.formatToValueCount(inspection), styles = ITALIC_STYLE_LIST)
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
            width { TABLE_WIDTH_PORTRAIT }
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

    private fun CriticalFinding.formatToValueCount(inspection: Inspection): String {
        val prefix = when (this) {
            CriticalFinding.STRUCTURAL -> "Structural"
            CriticalFinding.SAFETY -> "Safety"
            CriticalFinding.OTHER -> "Other"
        }
        val count = inspection.getCriticalFindingCount(this).toString()

        return String.format(FORMAT_KEY_VALUE, prefix, count)
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

        observationRepository.findAllByInspectionIdAndDeletedIsFalse(inspection.uuid)
            .sortedBy { it.structuralComponent?.name }
            .groupBy { it.structuralComponent }
            .forEach {
                val component = it.key ?: return@forEach
                val list = it.value.map {
                    DefectSummaryFields.ObservationData(it, observationService)
                }
                val totalHealthIndex: Double = list.sumByDouble { it.healthIndex } / list.size

                table {
                    width { TABLE_WIDTH_PORTRAIT }
                    DefectSummaryFields.buildHeaderRows(this, component.name, totalHealthIndex)
                    list.forEach {
                        row {
                            DefectSummaryFields.buildCells(this, it)
                        }
                    }
                }
                paragraph {
                    lineFeed { DOUBLE_LINE_FEED_ELEMENT }
                }
            }
    }

    private fun Page.Builder.createDefectReportPage(inspection: Inspection, inspector: User, structure: Structure?, observation: Observation, defect: ObservationDefect) {
        paragraph {
            text { OBSERVATION_REPORT_SUMMARY_ELEMENT }
        }

        table {
            borders { false }
            width { TABLE_WIDTH_PORTRAIT }
            row {
                DefectFields.CELLS_ALIGNMENT_MAP.forEach {
                    cell {
                        width { TABLE_WIDTH_PORTRAIT / 2 }
                        paragraph {
                            alignment { it.key }
                            it.value.forEach { field ->
                                elementsKeyValue(field.title, field.getValue(inspection, structure, observation, defect, observationDefectRepository, photoRepository), SMALL_TEXT_SIZE)
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
            width { (TABLE_WIDTH_PORTRAIT * 0.8).toInt() }
            borders { false }
            rowsPictures(inspection, inspector, defect)
        }

        paragraph {
            lineFeed { SINGLE_LINE_FEED_ELEMENT }
            text { INSPECTOR_SIGNATURE_ELEMENT }
        }
    }

    private fun Table.Builder.rowsPictures(inspection: Inspection, inspector: User, defect: ObservationDefect) {
        val photosSize = photoRepository.countByObservationDefectIdAndDeletedIsFalse(defect.uuid).toInt()
        for (i in 0..(photosSize - 1) / 2) {
            row {
                cell {
                    paragraphPhoto(inspection, inspector, defect, i * 2)
                }
                cell {
                    width { PICTURE_SPACE_CELL_WIDTH }
                    paragraphLeft {
                        text { PHOTO_SPACE_ELEMENT }
                        lineFeed { SINGLE_LINE_FEED_ELEMENT }
                    }
                }
                cell {
                    paragraphPhoto(inspection, inspector, defect, i * 2 + 1)
                }
            }
        }
    }

    private fun Row.Cell.Builder.paragraphPhoto(inspection: Inspection, inspector: User, defect: ObservationDefect, index: Int) {
        paragraphLeft {
            text { PHOTO_SPACE_ELEMENT }
            lineFeed { SINGLE_LINE_FEED_ELEMENT }
            photoRepository.findAllByObservationDefectIdAndDeletedIsFalse(defect.uuid).getOrNull(index)?.let { photo ->
                try {
                    fileService.get(photo.link, photo.drawables, true)?.also {
                        picture(photo.name, it, DEFECT_PHOTO_SIZE, DEFECT_PHOTO_SIZE)
                        text { SPACE_ELEMENT }
                        lineFeed { SINGLE_LINE_FEED_ELEMENT }
                        text(photo.name, textSize = 6)
                        lineFeed { SINGLE_LINE_FEED_ELEMENT }
                        text { LinkTextElement.Simple(photo.getUrl(configuration.server.host, inspection, inspector), textSize = 6) }
                    }
                } catch (e: Exception) {
                    logger.error("Not found photo ${e.message}")
                }
            }
        }
    }

    private fun Paragraph.Builder.elementsKeyValue(key: String, value: String?, fontSize: Int? = null) {
        text(key, textSize = fontSize, styles = BOLD_STYLE_LIST)
        text(value, textSize = fontSize)
        lineFeed { SINGLE_LINE_FEED_ELEMENT }
    }

    private fun Page.Builder.createNonStructuralDefectsReport(inspection: Inspection, inspector: User) {
        createDefectsReport(inspection, inspector, NON_STRUCTURAL_DEFECTS_REPORT_ELEMENT, StructuralType.MAINTENANCE)
    }

    private fun Page.Builder.createStructuralDefectsReport(inspection: Inspection, inspector: User) {
        createDefectsReport(inspection, inspector, STRUCTURAL_DEFECTS_REPORT_ELEMENT, StructuralType.STRUCTURAL)
    }

    private fun Page.Builder.createDefectsReport(inspection: Inspection, inspector: User, title: TextElement, type: StructuralType) {
        paragraph {
            text { title }
            lineFeed { SINGLE_LINE_FEED_ELEMENT }
        }

        orientation = Page.Orientation.LANDSCAPE

        table {
            width { TABLE_WIDTH_LANDSCAPE }
            DefectsReportFields.buildHeaderRows(this)
            DefectsReportFields.buildRows( this, inspection, inspector, type, configuration.server.host, observationRepository, observationDefectRepository)
        }
    }

    private fun Inspection.getStationing(structure: Structure?): String {
            val beginStationing = structure?.beginStationing
            val endStationing = structure?.endStationing

            return if (beginStationing != null && endStationing != null) {
                "$beginStationing to $endStationing"
            } else beginStationing ?: endStationing ?: ""
    }

    private fun Inspection.getWeatherText(): String? {
        return if (temperature != null) "T $temperature℉ Hum $humidity% Wind $wind m/h" else null
    }

    private fun Double?.formatSgrRating() = this?.let { DecimalFormat("0.##").format(it) }

    private fun Inspection.getCriticalFindingCount(criticalFinding: CriticalFinding): Int {
        return observationRepository.findAllByInspectionIdAndDeletedIsFalse(uuid).sumBy { observation: Observation ->
            observationDefectRepository.findAllByObservationIdAndDeletedIsFalse(observation.uuid).sumBy { defect: ObservationDefect ->
                if (defect.criticalFindings != null && defect.criticalFindings!!.contains(criticalFinding)) 1 else 0
            }
        }
    }

    private fun Photo.getUrl(server: String, inspection: Inspection, inspector: User): String? {
        val inspectorId = inspector?.id ?: return null
        var observationDefect: ObservationDefect? = null

        val observation = observationRepository.findAllByInspectionIdAndDeletedIsFalse(inspection.uuid).firstOrNull {
            observationDefectRepository.findAllByObservationIdAndDeletedIsFalse(it.uuid).indexOfFirst { defect ->
                val photos = photoRepository.findAllByObservationDefectIdAndDeletedIsFalse(defect.uuid)
                photos.forEach { photo ->
                    if (photo.uuid == uuid) {
                        observationDefect = defect
                    }
                }
                observationDefect != null
            } >= 0
        }

        return "$server/datarecon/$inspectorId/${inspection.uuid}/${observation?.id}/${observationDefect?.id}/$name"
    }
}
