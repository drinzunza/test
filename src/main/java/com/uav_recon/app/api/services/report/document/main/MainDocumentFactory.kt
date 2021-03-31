package com.uav_recon.app.api.services.report.document.main

import com.uav_recon.app.api.entities.db.*
import com.uav_recon.app.api.entities.responses.bridge.ObservationDefectReportDto
import com.uav_recon.app.api.entities.responses.bridge.SubcomponentHealthDto
import com.uav_recon.app.api.repositories.*
import com.uav_recon.app.api.services.FileService
import com.uav_recon.app.api.services.InspectionService
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
import com.uav_recon.app.api.utils.toDate
import com.uav_recon.app.configurations.UavConfiguration
import org.slf4j.LoggerFactory
import org.springframework.stereotype.Service
import java.nio.file.Path
import java.nio.file.Paths
import java.text.DecimalFormat
import java.text.SimpleDateFormat
import java.util.*
import kotlin.collections.ArrayList
import kotlin.collections.HashMap
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
        private val inspectionService: InspectionService,
        private val inspectionRepository: InspectionRepository,
        private val observationService: ObservationService,
        private val structureRepository: StructureRepository,
        private val userRepository: UserRepository,
        private val companyRepository: CompanyRepository,
        private val configuration: UavConfiguration,
        private val fileService: FileService,
        private val projectRepository: ProjectRepository,
        private val structureTypeRepository: StructureTypeRepository
) : DocumentFactory {

    private val fileStorageLocation: Path = Paths.get(configuration.files.uploadDir).toAbsolutePath().normalize()
    private val logger = LoggerFactory.getLogger(MainDocumentFactory::class.java)

    companion object {

        const val INDEX_TAG = "INDEX_TAG"
        const val DEFECT_TAG = "DEFECT_TAG"
        const val SUB_COMPONENT_TAG = "SUB_COMPONENT_TAG"
        const val LOCATION_TAG = "LOCATION_TAG"
        const val PREV_DEF_ID_TAG = "PREV_DEF_ID_TAG"
        const val DATE_TAG = "DATE_TAG"
        const val STATION_TAG = "STATION_TAG"
        const val DEFECT_DESCRIPTION_TAG = "DEFECT_DESCRIPTION_TAG"
        const val SIZE_TAG = "SIZE_TAG"
        const val IMAGE_TAG = "IMAGE_TAG"
        const val CS_TAG = "CS_TAG"
        const val CRITICAL_FINDING_TAG = "CRITICAL_FINDING_TAG"
        const val CORRECTIVE_ACTION_TAG = "CORRECTIVE_ACTION_TAG"
        const val REPAIR_TAG = "REPAIR_TAG"
        const val REPAIR_DATE_TAG = "REPAIR_DATE"
        const val OBSERVATION_ID_TAG = "OBSERVATION_ID_TAG"
        const val PREV_OBSERVATION_ID_TAG = "PREV_OBSERVATION_ID_TAG"
        const val OBSERVATION_NAME_TAG = "OBSERVATION_NAME_TAG"

        internal val DATE_FORMAT = SimpleDateFormat("MM/dd/yyyy", Locale.US)
        private const val FORMAT_KEY_VALUE = "%s: %s"

        private val BORDER: Document.Border = Document.Border.Simple(BORDER_SIZE, BORDER_SPACE, ReportConstants.COLOR_BLACK)
        internal val BOLD_STYLE_LIST = listOf(BOLD)
        internal val ITALIC_STYLE_LIST = listOf(ITALIC)
        internal val ITALIC_BOLD_STYLE_LIST = listOf(ITALIC, BOLD)

        private val SINGLE_LINE_FEED_ELEMENT = LineFeedElement.Simple(1)
        private val DOUBLE_LINE_FEED_ELEMENT = LineFeedElement.Simple(2)
        private val TRIPLE_LINE_FEED_ELEMENT = LineFeedElement.Simple(3)

        private val SPACE_ELEMENT = TextElement.Simple("----", textSize = 6, textColor = ReportConstants.COLOR_WHITE)
        private val PHOTO_SPACE_ELEMENT = TextElement.Simple("    --    ", textColor = ReportConstants.COLOR_WHITE)

        private const val PERCENT = "%"
        private const val INSPECTED_BY_FORMAT = "Inspected By: %s (User id: %s)"

        private const val ACTION_REPAIR_SCHEDULE = "Action & Repair Schedule: "
        private const val DEFECT_DESCRIPTION = "Defect description: "
        private const val OBSERVATION_DESCRIPTION = "Observation description: "

        private val OBSERVATION_SUMMARY_ELEMENT = TextElement.Simple("Summary of Observations by", styles = BOLD_STYLE_LIST)
        private val MAJOR_STRUCTURAL_ELEMENT = TextElement.Simple("Major Structural Component", styles = BOLD_STYLE_LIST)

        private val OBSERVATION_REPORT_SUMMARY_ELEMENT = TextElement.Simple("Observation Report Summary", styles = ITALIC_BOLD_STYLE_LIST)
        private val DEFECT_PHOTOS_ELEMENT = TextElement.Simple("Inspection Photographs of Defects", styles = ITALIC_BOLD_STYLE_LIST)
    }

    override fun generateDocument(report: Report): Document {
        val inspection = report.getInspection()
        logger.info("start fill objects")
        inspectionService.fillObjects(listOf(inspection))
        logger.info("stop fill objects")
        val structure = inspection.getStructure()
        val inspector = inspection.getInspector()
        val company = inspector.getCompany()
        val structureType = structure?.structureTypeId

        // Default sort by components, sub-components, station marker.
        inspection.observations = inspection.observations
                ?.sortedWith(compareBy({it.component?.name}, {it.subcomponent?.name}))
        inspection.observations?.forEach { observation ->
            observation.defects = observation.defects?.sortedWith(compareBy { it.stationMarker })
        }

        // Put all defects in one list.
        var defectList : MutableList<ObservationDefect> = ArrayList()
        var maintenanceList: MutableList<ObservationDefect> = ArrayList()
        // Create a map of defect id to observation for faster access.
        val defectToObservationMap : HashMap<String, Observation> = HashMap()
        inspection.observations?.forEach { observation ->
            observation.defects?.forEach {
                if(it.type == StructuralType.STRUCTURAL){
                    defectList.add(it)
                } else {
                    maintenanceList.add(it)
                }
                defectToObservationMap[it.id] = observation
            }
        }

        // If structure is of type tunnel, sort defects by station marker.
        if(structureType == 4L){
            defectList = defectList.sortedWith(compareBy { it.stationMarker }).toMutableList()
            maintenanceList = maintenanceList.sortedWith(compareBy { it.stationMarker }).toMutableList()
        }

        val infraStructureTypes = arrayOf(1,2,3,4,6,7)
        val flavor = if (structure?.structureTypeId?.toInt() in infraStructureTypes) "default" else "non-infra"

        return Document.create {
            border { BORDER }

            page { createTitlePage(report, inspection, inspector, structure, company, flavor) }
            page { createGlobalPage(inspection, flavor) }
            page { createStructuralDefectsReport(inspection, inspector, structureType == 4L, flavor) }
            if(CustomReportManager.getInstance().isVisible("maintenance_observation_section", flavor)){
                page { createNonStructuralDefectsReport(inspection, inspector, structureType == 4L, flavor) }
            }
            page { createObservationSummary(inspection) }

            defectList.forEach { defect ->
                    page { createDefectReportPage(inspection, inspector, structure, defectToObservationMap[defect.id]!!, defect) }
            }
            maintenanceList.forEach { defect ->
                page { createDefectReportPage(inspection, inspector, structure, defectToObservationMap[defect.id]!!, defect) }
            }
        }
    }

    private fun Page.Builder.createTitlePage(report: Report, inspection: Inspection?, inspector: User?, structure: Structure?, company: Company?, flavor: String?) {

         val structureTypeElement = TextElement.Simple(CustomReportManager.getInstance().getString("structure_type", flavor), styles = BOLD_STYLE_LIST)
         val structureIdElement = TextElement.Simple(CustomReportManager.getInstance().getString("structure_id", flavor), styles = BOLD_STYLE_LIST)
         val caltranNoElement =
                TextElement.Simple(CustomReportManager.getInstance().getString("caltrans_no", flavor), textSize = SMALL_TEXT_SIZE, styles = ITALIC_BOLD_STYLE_LIST)
         val postMileElement = TextElement.Simple(CustomReportManager.getInstance().getString("post_mile", flavor), textSize = SMALL_TEXT_SIZE, styles = ITALIC_BOLD_STYLE_LIST)
         val stationingElement = TextElement.Simple(CustomReportManager.getInstance().getString("stationing", flavor), textSize = SMALL_TEXT_SIZE, styles = ITALIC_BOLD_STYLE_LIST)
         val primaryOwnerElement =
                TextElement.Simple(CustomReportManager.getInstance().getString("primary_owner", flavor), styles = BOLD_STYLE_LIST)
         val structureNumberElement =
                TextElement.Simple(CustomReportManager.getInstance().getString("structure_name", flavor), styles = BOLD_STYLE_LIST)
         val reportPreparedElement = TextElement.Simple(CustomReportManager.getInstance().getString("report_prepared_by", flavor), styles = BOLD_STYLE_LIST)
         val reportNumberElement = TextElement.Simple(CustomReportManager.getInstance().getString("report_no", flavor))
         val reportDateElement = TextElement.Simple(CustomReportManager.getInstance().getString("report_date", flavor))
         val inspectionDateElement = TextElement.Simple(CustomReportManager.getInstance().getString("inspection_date", flavor))

        paragraph {
            createElements(
                TRIPLE_LINE_FEED_ELEMENT,
                    structureTypeElement,
                    structureTypeRepository.findAll().find { it.id == structure?.structureTypeId }?.code ?: ""
            )
            createElements(prefix = structureIdElement, text = structure?.code)
            createElements(prefix = structureNumberElement, text = structure?.name)
            createElements(prefix = primaryOwnerElement, text = structure?.primaryOwner)
            lineFeed { LineFeedElement.Simple(1) }
            if(CustomReportManager.getInstance().isVisible("bridge_info_visible", flavor)) {
                createElements(
                        prefix = caltranNoElement,
                        text = structure?.caltransBridgeNo,
                        textStyles = listOf(),
                        textSize = SMALL_TEXT_SIZE
                )
                createElements(
                        prefix = postMileElement,
                        text = structure?.postmile?.toString(),
                        textStyles = listOf(),
                        textSize = SMALL_TEXT_SIZE
                )
                createElements(prefix = stationingElement, text = inspection?.getStationing(structure) ?: "", textStyles = listOf(), textSize = SMALL_TEXT_SIZE)
            }
            lineFeed { LineFeedElement.Simple(7) }
            text { reportPreparedElement }
            lineFeed { SINGLE_LINE_FEED_ELEMENT }
            picture(
                company?.name ?: "Demo Company",
                fileStorageLocation.resolve(company?.logo?.split("/")?.last() ?: "logo_datarecon.png").toFile().inputStream(),
                LOGO_WIDTH,
                LOGO_HEIGHT
            )
            lineFeed { LineFeedElement.Simple(4) }
            text { reportNumberElement }
            text(report.id, styles = ITALIC_STYLE_LIST)
            lineFeed { SINGLE_LINE_FEED_ELEMENT }
            text { reportDateElement }
            text(formatDate(), styles = ITALIC_STYLE_LIST)
            lineFeed { SINGLE_LINE_FEED_ELEMENT }
            text { inspectionDateElement }
            text(formatDate(inspection?.startDate?.toDate() ?: Date()), styles = ITALIC_STYLE_LIST)
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

    private fun Page.Builder.createGlobalPage(inspection: Inspection, flavor: String?) {
        val criticalFindElement =
                TextElement.Simple(CustomReportManager.getInstance().getString("critical_findings", flavor), styles = ITALIC_BOLD_STYLE_LIST)
        val structureConditionCodeElement =
                TextElement.Simple(CustomReportManager.getInstance().getString("structure_condition_code", flavor), styles = ITALIC_BOLD_STYLE_LIST)
        val generalInspectionElement = TextElement.Simple(CustomReportManager.getInstance().getString("general_inspection_summary", flavor), styles = BOLD_STYLE_LIST)
        val sgrRating = CustomReportManager.getInstance().getString("sgr_rating", flavor)
        val termRating = CustomReportManager.getInstance().getString("term_rating", flavor)
//        mapLoaderService.loadImage(inspection)?.let {
//            paragraph {
//                picture(inputStream = it, width = MAP_PICTURE_WIDTH, height = MAP_PICTURE_HEIGHT)
//                lineFeed { DOUBLE_LINE_FEED_ELEMENT }
//            }
//        }
        table {
            width { TABLE_WIDTH_PORTRAIT }
            row {
                if(CustomReportManager.getInstance().isVisible("critical_findings_visible", flavor)){
                    cell {
                        paragraph {
                            text { criticalFindElement }
                        }
                    }
                }
                cell {
                    paragraph {
                        text { structureConditionCodeElement }
                    }
                }
            }
            row {
                if(CustomReportManager.getInstance().isVisible("critical_findings_visible", flavor)) {
                    cell {
                        paragraph {
                            val values = CriticalFinding.values()
                            values.forEachIndexed { index, value ->
                                text(value.formatToValueCount(inspection), styles = ITALIC_STYLE_LIST)
                                if (index != values.size - 1) lineFeed { SINGLE_LINE_FEED_ELEMENT }
                            }
                        }

                    }
                }
                cell {
                    paragraph {
                        val sqrRating = inspectionService.calculateSgrRating(inspection)
                        if(CustomReportManager.getInstance().isVisible("percentage_scale", flavor)) {
                            text(formatRating(sgrRating, sqrRating, PERCENT), styles = ITALIC_STYLE_LIST)
                        } else {
                            var digit_sgr = 1
                            if(sqrRating != null){
                                digit_sgr = if(sqrRating > 80){
                                    1
                                } else if(sqrRating > 60){
                                    2
                                } else if(sqrRating > 40){
                                    3
                                } else if(sqrRating > 20){
                                    4
                                } else {
                                    5
                                }
                            }

                            text(formatRating(sgrRating, digit_sgr, ""), styles = ITALIC_STYLE_LIST)
                        }
                        if(CustomReportManager.getInstance().isVisible("term_rating_visible", flavor)){
                            lineFeed { SINGLE_LINE_FEED_ELEMENT }
                            text(formatRating(termRating, inspection.termRating?.formatTermRating() ?: "0.0"), styles = ITALIC_STYLE_LIST)
                        }
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
                        text { generalInspectionElement }
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

        inspection.observations
                ?.sortedBy { it.component?.name }
                ?.groupBy { it.component }
                ?.forEach {
                    val component = it.key ?: return@forEach
                    val list = it.value.map { observation ->
                        val spansCount = observationService.getSpansCount(observation, inspection.spansCount) ?: 0
                        DefectSummaryFields.ObservationData(observation, spansCount, observationService)
                    }.filter { it.totalQuantity > 0 }

                    if (list.isNotEmpty()) {
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
    }

    private fun Page.Builder.createDefectReportPage(inspection: Inspection, inspector: User, structure: Structure?, observation: Observation, defect: ObservationDefect) {



        paragraph {
            text { OBSERVATION_REPORT_SUMMARY_ELEMENT }
        }

        table {
            borders { false }
            width { TABLE_WIDTH_PORTRAIT }
            row {
                DefectFields.getCellAlignmentMap(defect).forEach {
                cell {
                        width { TABLE_WIDTH_PORTRAIT / 2 }
                        paragraph {
                            alignment { it.key }
                            it.value.forEach { field ->
                                elementsKeyValue(field.title, field.getValue(inspection, structure, observation, defect), SMALL_TEXT_SIZE)
                            }
                        }
                    }
                }
            }
        }

        paragraphLeft {
            val type = when (defect.observationType) {
                ObservationType.CRITICAL -> "A"
                ObservationType.PRIORITY -> "B"
                ObservationType.ROUTINE -> "C"
                ObservationType.MONITOR -> "D"
                else -> null
            }
            val schedule = if (defect.repairMethod == null && defect.repairDate == null && type == null)
                    null else "${type ?: ""} - ${defect.repairMethod ?: ""} prior to ${defect.repairDate ?: ""}"
            elementsKeyValue(ACTION_REPAIR_SCHEDULE, schedule, SMALL_TEXT_SIZE)
            val title = when (defect.type) {
                StructuralType.STRUCTURAL -> DEFECT_DESCRIPTION
                StructuralType.MAINTENANCE -> OBSERVATION_DESCRIPTION
                else -> DEFECT_DESCRIPTION
            }
            elementsKeyValue(title, defect.description, SMALL_TEXT_SIZE)
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
    }

    private fun Table.Builder.rowsPictures(inspection: Inspection, inspector: User, defect: ObservationDefect) {
        val photosSize = defect.photos?.size ?: 0
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
            defect.photos?.getOrNull(index)?.let { photo ->
                try {
                    fileService.get(photo.link, photo.drawables, FileService.FileType.WITH_RECT_THUMB).also {
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

    private fun Page.Builder.createNonStructuralDefectsReport(inspection: Inspection, inspector: User, sortByStationing: Boolean, flavor: String) {
        val title = TextElement.Simple(CustomReportManager.getInstance().getString("non_structural_defects_report", flavor), styles = ITALIC_BOLD_STYLE_LIST)
        createDefectsReport(inspection, inspector, title, StructuralType.MAINTENANCE, sortByStationing, flavor)
    }

    private fun Page.Builder.createStructuralDefectsReport(inspection: Inspection, inspector: User, sortByStationing: Boolean, flavor: String) {
        val title = TextElement.Simple(CustomReportManager.getInstance().getString("structural_defects_report", flavor), styles = ITALIC_BOLD_STYLE_LIST)
        createDefectsReport(inspection, inspector, title, StructuralType.STRUCTURAL, sortByStationing, flavor)
    }

    private fun Page.Builder.createDefectsReport(inspection: Inspection, inspector: User, title: TextElement, type: StructuralType, sortByStationing: Boolean, flavor: String) {
        orientation = Page.Orientation.LANDSCAPE

        val indexElement = Triple(TextElement.Simple(CustomReportManager.getInstance().getString("index", flavor), styles = MainDocumentFactory.BOLD_STYLE_LIST, textSize = SMALL_TABLE_TEXT_SIZE),
                0.0417f, INDEX_TAG)
        val defectIdElement = Triple(TextElement.Simple(CustomReportManager.getInstance().getString("defect_id", flavor), styles = MainDocumentFactory.BOLD_STYLE_LIST, textSize = SMALL_TABLE_TEXT_SIZE),
                0.0986f, DEFECT_TAG)
        val observationIdElement = Triple(TextElement.Simple(CustomReportManager.getInstance().getString("observation_id", flavor), styles = MainDocumentFactory.BOLD_STYLE_LIST, textSize = SMALL_TABLE_TEXT_SIZE),
                0.0986f, OBSERVATION_ID_TAG)
        val subComponentElement = Triple(TextElement.Simple(CustomReportManager.getInstance().getString("sub_component", flavor), styles = MainDocumentFactory.BOLD_STYLE_LIST, textSize = SMALL_TABLE_TEXT_SIZE),
                0.1236f, SUB_COMPONENT_TAG)
        val locationIdElement = Triple(TextElement.Simple(CustomReportManager.getInstance().getString("location_id", flavor), styles = MainDocumentFactory.BOLD_STYLE_LIST, textSize = SMALL_TABLE_TEXT_SIZE),
                0.0653f, LOCATION_TAG)
        val prevDefIdElement = Triple(TextElement.Simple(CustomReportManager.getInstance().getString("prev_def_id", flavor), styles = MainDocumentFactory.BOLD_STYLE_LIST, textSize = SMALL_TABLE_TEXT_SIZE),
                0.0417f, PREV_DEF_ID_TAG)
        val prevObsIdElement = Triple(TextElement.Simple(CustomReportManager.getInstance().getString("prev_obs_id", flavor), styles = MainDocumentFactory.BOLD_STYLE_LIST, textSize = SMALL_TABLE_TEXT_SIZE),
                0.0417f, PREV_OBSERVATION_ID_TAG)
        val dateElement = Triple(TextElement.Simple(CustomReportManager.getInstance().getString("inspection_date_table", flavor), styles = MainDocumentFactory.BOLD_STYLE_LIST, textSize = SMALL_TABLE_TEXT_SIZE),
                0.0653f, DATE_TAG)
        val stationElement = Triple(TextElement.Simple(CustomReportManager.getInstance().getString("station", flavor), styles = MainDocumentFactory.BOLD_STYLE_LIST, textSize = SMALL_TABLE_TEXT_SIZE),
                0.0764f, STATION_TAG)
        val defectDescriptionElement = Triple(TextElement.Simple(CustomReportManager.getInstance().getString("defect_description_table", flavor), styles = MainDocumentFactory.BOLD_STYLE_LIST, textSize = SMALL_TABLE_TEXT_SIZE),
                0.1194f, DEFECT_DESCRIPTION_TAG)
        val observationNameElement = Triple(TextElement.Simple(CustomReportManager.getInstance().getString("observation_name", flavor), styles = MainDocumentFactory.BOLD_STYLE_LIST, textSize = SMALL_TABLE_TEXT_SIZE),
                0.1194f, OBSERVATION_NAME_TAG)
        val sizeElement = Triple(TextElement.Simple(CustomReportManager.getInstance().getString("size", flavor), styles = MainDocumentFactory.BOLD_STYLE_LIST, textSize = SMALL_TABLE_TEXT_SIZE),
                0.0458f, SIZE_TAG)
        val imageElement = Triple(TextElement.Simple(CustomReportManager.getInstance().getString("image", flavor), styles = MainDocumentFactory.BOLD_STYLE_LIST, textSize = SMALL_TABLE_TEXT_SIZE),
                0.0375f, IMAGE_TAG)
        val csRatingElement = Triple(TextElement.Simple(CustomReportManager.getInstance().getString("cs", flavor), styles = MainDocumentFactory.BOLD_STYLE_LIST, textSize = SMALL_TABLE_TEXT_SIZE),
                0.0361f, CS_TAG)
        val criticalFindingsElement = Triple(TextElement.Simple(CustomReportManager.getInstance().getString("critical_findings_table", flavor), styles = MainDocumentFactory.BOLD_STYLE_LIST, textSize = SMALL_TABLE_TEXT_SIZE),
                0.06f, CRITICAL_FINDING_TAG)
        val correctiveActionElement = Triple(TextElement.Simple(CustomReportManager.getInstance().getString("corrective_action", flavor), styles = MainDocumentFactory.BOLD_STYLE_LIST, textSize = SMALL_TABLE_TEXT_SIZE),
                0.0458f, CORRECTIVE_ACTION_TAG)
        val repairMethodElement = Triple(TextElement.Simple(CustomReportManager.getInstance().getString("repair_method", flavor), styles = MainDocumentFactory.BOLD_STYLE_LIST, textSize = SMALL_TABLE_TEXT_SIZE),
                0.0757f, REPAIR_TAG)
        val repairDateElement = Triple(TextElement.Simple(CustomReportManager.getInstance().getString("repair_date", flavor), styles = MainDocumentFactory.BOLD_STYLE_LIST, textSize = SMALL_TABLE_TEXT_SIZE),
                0.0657f, REPAIR_DATE_TAG)

        val map: HashMap<StructuralType, ArrayList<Triple<TextElement, Float, String>>> = HashMap()
        map[StructuralType.STRUCTURAL] = ArrayList()
        map[StructuralType.STRUCTURAL]?.add(indexElement)
        map[StructuralType.STRUCTURAL]?.add(defectIdElement)
        map[StructuralType.STRUCTURAL]?.add(subComponentElement)
        if(CustomReportManager.getInstance().isVisible("location_id_column", flavor)) {
            map[StructuralType.STRUCTURAL]?.add(locationIdElement)
        }
        map[StructuralType.STRUCTURAL]?.add(prevDefIdElement)
        map[StructuralType.STRUCTURAL]?.add(dateElement)
        if(CustomReportManager.getInstance().isVisible("station_column", flavor)) {
            map[StructuralType.STRUCTURAL]?.add(stationElement)
        }
        map[StructuralType.STRUCTURAL]?.add(defectDescriptionElement)
        map[StructuralType.STRUCTURAL]?.add(sizeElement)
        map[StructuralType.STRUCTURAL]?.add(imageElement)
        map[StructuralType.STRUCTURAL]?.add(csRatingElement)
        if(CustomReportManager.getInstance().isVisible("critical_findings_column", flavor)) {
            map[StructuralType.STRUCTURAL]?.add(criticalFindingsElement)
        }
        if(CustomReportManager.getInstance().isVisible("corrective_action_column", flavor)) {
            map[StructuralType.STRUCTURAL]?.add(correctiveActionElement)
        }
        map[StructuralType.STRUCTURAL]?.add(repairMethodElement)
        map[StructuralType.STRUCTURAL]?.add(repairDateElement)

        map[StructuralType.MAINTENANCE] = ArrayList()
        map[StructuralType.MAINTENANCE]?.add(indexElement)
        map[StructuralType.MAINTENANCE]?.add(observationIdElement)
        map[StructuralType.MAINTENANCE]?.add(subComponentElement)
        map[StructuralType.MAINTENANCE]?.add(locationIdElement)
        map[StructuralType.MAINTENANCE]?.add(prevObsIdElement)
        map[StructuralType.MAINTENANCE]?.add(dateElement)
        map[StructuralType.MAINTENANCE]?.add(stationElement)
        map[StructuralType.MAINTENANCE]?.add(observationNameElement)
        map[StructuralType.MAINTENANCE]?.add(sizeElement)
        map[StructuralType.MAINTENANCE]?.add(imageElement)
        map[StructuralType.MAINTENANCE]?.add(csRatingElement)
        map[StructuralType.MAINTENANCE]?.add(criticalFindingsElement)
        map[StructuralType.MAINTENANCE]?.add(correctiveActionElement)
        map[StructuralType.MAINTENANCE]?.add(repairMethodElement)
        map[StructuralType.MAINTENANCE]?.add(repairDateElement)

        paragraph {
            text { title }
            lineFeed { SINGLE_LINE_FEED_ELEMENT }
        }

        table {
            width { TABLE_WIDTH_LANDSCAPE }
            with(DefectsReportFields) {
                buildHeaderRow(map[type]?.toList())
                buildRows(inspection, inspector, type, configuration.server.host, sortByStationing, map[type]?.toList())
            }
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
    private fun Double?.formatTermRating() = this?.let { String.format("%.1f", it) }

    private fun Inspection.getCriticalFindingCount(criticalFinding: CriticalFinding): Int {
        return observations?.sumBy { observation: Observation ->
            observation.defects?.sumBy { defect: ObservationDefect ->
                if (defect.criticalFindings?.contains(criticalFinding) == true) 1 else 0
            } ?: 0
        } ?: 0
    }

    private fun Photo.getUrl(server: String, inspection: Inspection, inspector: User): String? {
        val inspectorId = inspector.id
        var observationDefect: ObservationDefect? = null

        val observation = inspection.observations?.firstOrNull {
            it.defects!!.indexOfFirst { defect ->
                defect.photos?.forEach { photo ->
                    if (photo.uuid == uuid) {
                        observationDefect = defect
                    }
                }
                observationDefect != null
            } >= 0
        }

        return "$server/datarecon-links/$inspectorId/${inspection.uuid}/${observation?.uuid}/${observationDefect?.uuid}/$uuid.jpeg"
    }

    private fun Report.getInspection(): Inspection {
        return inspectionRepository.findFirstByUuidAndDeletedIsFalse(inspectionId)!!
    }

    private fun Inspection.getStructure(): Structure? {
        return structureId?.let { structureRepository.findFirstById(it) }
    }

    private fun Inspection.getInspector(): User {
        return userRepository.findFirstById(updatedBy.toLong())!!
    }

    private fun User.getCompany(): Company {
        return companyRepository.findFirstById(companyId!!)!!
    }

    fun createObservationSummary(inspections: List<Inspection>): List<SubcomponentHealthDto> {
        inspectionService.fillObjects(inspections)

        val structures = structureRepository.findAllByIdIn(inspections.map { it.structureId ?: "" })
        val results = mutableListOf<SubcomponentHealthDto>()
        for (inspection in inspections) {
            inspection.observations
                    ?.sortedBy { it.component?.name }
                    ?.groupBy { it.component }
                    ?.forEach {
                        val component = it.key ?: return@forEach
                        val list = it.value.map { observation ->
                            val spansCount = observationService.getSpansCount(observation, inspection.spansCount) ?: 0
                            DefectSummaryFields.ObservationData(observation, spansCount, observationService)
                        }
                        val totalHealthIndex: Double = list.sumByDouble { it.healthIndex } / list.size

                        list.forEach {
                            val structure = structures.firstOrNull { it.id == inspection.structureId }
                            results.add(SubcomponentHealthDto(
                                    id = it.subComponentId,
                                    structureId = structure?.id,
                                    structureName = structure?.name,
                                    structureCode = structure?.code,
                                    inspectionId = inspection.uuid,
                                    inspectionDate = inspection.startDate,
                                    componentName = component.name,
                                    subcomponentName = it.subComponentName,
                                    subcomponentHealthIndex = it.healthIndex,
                                    componentHealthIndex = totalHealthIndex,
                                    conditionRating1 = it.cs1,
                                    conditionRating2 = it.cs2,
                                    conditionRating3 = it.cs3,
                                    conditionRating4 = it.cs4
                            ))
                        }
                    }
        }
        logger.info("Get ${results.size} subcomponents")
        return results
    }

    fun createObservationDefectSummary(inspections: List<Inspection>): List<ObservationDefectReportDto> {
        inspectionService.fillObjects(inspections)

        val structures = structureRepository.findAllByIdIn(inspections.map { it.structureId ?: "" })
        val projects = projectRepository.findAllByIdIn(inspections.map { it.projectId ?: 0 })
        val users = userRepository.findAllByIdIn(inspections.map { it.createdBy.toLong() })

        val defectUserIds = mutableListOf<Int>()
        inspections.forEach { it.observations?.forEach { it.defects?.forEach { defectUserIds.add(it.createdBy) } } }
        val defectUsers = userRepository.findAllByIdIn(defectUserIds.map { it.toLong() })

        val results = mutableListOf<ObservationDefectReportDto>()
        for (inspection in inspections) {
            inspection.observations
                    ?.sortedBy { it.component?.name }
                    ?.forEach { observation ->
                        observation.defects?.forEach {
                            val observationDefect = it
                            val inspector = defectUsers.firstOrNull { it.id == observationDefect.createdBy.toLong() }
                            val structure = structures.firstOrNull { it.id == inspection.structureId }
                            results.add(ObservationDefectReportDto(
                                    uuid = it.uuid,
                                    id = it.id,
                                    stationMarker = it.stationMarker,
                                    clockPosition = it.clockPosition,
                                    observationType = it.observationType,
                                    classification = it.type,
                                    locationId = it.span,
                                    summary = it.description,
                                    description = it.defect?.name,
                                    repairMethod = it.repairMethod,
                                    repairDate = it.repairDate,
                                    size = it.size,
                                    componentName = observation.component?.name,
                                    subcomponentName = observation.subcomponent?.name,
                                    subcomponentMeasureUnit = observation.subcomponent?.measureUnit,
                                    dimensionNumber = observation.dimensionNumber,
                                    csRating = it.condition?.type?.title,
                                    pictureLinks = it.photos?.map { fileService.getImagePath(it.link, null, FileService.FileType.WITH_RECT) } ?: listOf(),
                                    inspectionId = inspection.uuid,
                                    inspectionDate = inspection.startDate,
                                    structureId = structure?.id,
                                    structureName = structure?.name,
                                    structureCode = structure?.code,
                                    projectId = inspection.projectId,
                                    projectName = projects.firstOrNull { it.id == inspection.projectId }?.name,
                                    inspectorName = inspector?.let { "${inspector.firstName} ${inspector.lastName}" },
                                    previousDefectNumber = observationDefect.previousDefectNumber,
                                    createdAt = it.createdAt
                            ))
                        }
                    }
        }
        logger.info("Get ${results.size} defects")
        return results
    }
}
