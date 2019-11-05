package com.uav_recon.app.api.services.report.apache

import com.uav_recon.app.api.beans.resources.Resources
import com.uav_recon.app.api.services.FileStorageService
import com.uav_recon.app.api.services.report.DocumentWriter
import com.uav_recon.app.api.services.report.MapLoaderService
import com.uav_recon.app.api.services.report.document.models.Document
import com.uav_recon.app.api.services.report.document.models.Page
import com.uav_recon.app.api.services.report.document.models.body.Paragraph
import com.uav_recon.app.api.services.report.document.models.body.Paragraph.Alignment.*
import com.uav_recon.app.api.services.report.document.models.body.Table
import com.uav_recon.app.api.services.report.document.models.elements.LineFeedElement
import com.uav_recon.app.api.services.report.document.models.elements.LinkTextElement
import com.uav_recon.app.api.services.report.document.models.elements.PictureElement
import com.uav_recon.app.api.services.report.document.models.elements.TextElement
import com.uav_recon.app.configurations.FileStorageConfiguration
import org.apache.poi.util.Units
import org.apache.poi.xwpf.usermodel.*
import org.openxmlformats.schemas.wordprocessingml.x2006.main.STBorder
import org.openxmlformats.schemas.wordprocessingml.x2006.main.STPageBorderOffset
import org.openxmlformats.schemas.wordprocessingml.x2006.main.STTblWidth
import org.slf4j.LoggerFactory
import org.springframework.stereotype.Service
import java.io.File
import java.io.FileOutputStream
import java.math.BigInteger

private const val FORMAT_COLOR = "%06X"

@Service
class ApachePoiWriterService(
        private val mapLoaderService: MapLoaderService,
        private val config: FileStorageConfiguration,
        private val fileStorageService: FileStorageService,
        private val resources: Resources
) : DocumentWriter {

    private val logger = LoggerFactory.getLogger(ApachePoiWriterService::class.java)

    init {
        // POI doesn't work without this properties
        System.setProperty("org.apache.poi.javax.xml.stream.XMLInputFactory", "com.fasterxml.aalto.stax.InputFactoryImpl")
        System.setProperty("org.apache.poi.javax.xml.stream.XMLOutputFactory", "com.fasterxml.aalto.stax.OutputFactoryImpl")
        System.setProperty("org.apache.poi.javax.xml.stream.XMLEventFactory", "com.fasterxml.aalto.stax.EventFactoryImpl")
    }

    override fun writeDocument(document: Document, file: File) {
        val wordDocument = XWPFDocument(resources.template.inputStream()) // Need to save styles
        document.writeTo(wordDocument)
        FileOutputStream(file).use {
            wordDocument.write(it)
        }
    }

    private fun Document.writeTo(doc: XWPFDocument) {
        border?.let {
            doc.addBorder(it, pageWidth, pageHeight)
        }
        pages.forEachIndexed { index, page ->
            doc.addPage(index, page)
        }
    }

    private fun XWPFDocument.addPage(index: Int, page: Page) {
        if (index > 0) {
            paragraph {
                textRun { addBreak(BreakType.PAGE) }
            }
        }
        page.elements.forEach { body ->
            when(body) {
                is Paragraph -> addParagraph(body)
                is Table -> addTable(body)
                else -> logger.info("Unsupported body type $body")
            }
        }
    }

    private fun XWPFDocument.addParagraph(value: Paragraph) {
        paragraph { addParagraph(value) }
    }

    private fun XWPFDocument.addTable(value: Table) {
        table {
            value.width?.let {
                val width = ctTbl.addNewTblPr().addNewTblW()
                width.type = STTblWidth.DXA
                width.w = BigInteger.valueOf(it.toLong())
            }
            if (!value.withBorders) ctTbl.tblPr.unsetTblBorders()
            value.list.forEachIndexed { index, row ->
                row(index) {
                    row.cells.forEachIndexed { index, cell ->
                        cell(index) {
                            cell.color?.let { color = it }
                            cell.width?.let {
                                ctTc.addNewTcPr().addNewTcW().w = BigInteger.valueOf(it.toLong())
                            }
                            cell.paragraph?.let {
                                paragraph { addParagraph(it) }
                            }
                        }
                    }
                }
            }
        }
    }

    private fun XWPFParagraph.addParagraph(value: Paragraph) {
        value.alignment?.let { alignment = it.toAlignment() }
        value.list.forEach {
            when(it) {
                is LineFeedElement -> blankLines(it.count)
                is LinkTextElement -> addLinkText(it)
                is TextElement -> addText(it)
                is PictureElement -> addPicture(it)
                else -> logger.info("Unsupported element $it")
            }
        }
    }

    private fun XWPFParagraph.addText(value: TextElement) {
        textRun {
            isItalic = value.styles.contains(TextElement.Typeface.ITALIC)
            isBold = value.styles.contains(TextElement.Typeface.BOLD)
            isStrikeThrough = value.styles.contains(TextElement.Typeface.STRIKE)
            if (value.styles.contains(TextElement.Typeface.UNDERLINE)) underline = UnderlinePatterns.SINGLE
            value.textSize?.let { fontSize = it }
            value.textColor?.let { color = it }
            setText(value.text)
        }
    }

    private fun XWPFParagraph.addLinkText(value: LinkTextElement) {
        val link = value.text
        val rId = part.packagePart.addExternalRelationship(link, XWPFRelation.HYPERLINK.relation).id
        val cthyperLink = ctp.addNewHyperlink()
        cthyperLink.id = rId
        cthyperLink.addNewR()
        val hyperlinkRun = XWPFHyperlinkRun(cthyperLink, cthyperLink.getRArray(0), this)
        value.textColor?.let {
            hyperlinkRun.color = it
        }
        value.textSize?.let { hyperlinkRun.fontSize = it }
        hyperlinkRun.underline = UnderlinePatterns.SINGLE

        hyperlinkRun.isItalic = value.styles.contains(TextElement.Typeface.ITALIC)
        hyperlinkRun.isBold = value.styles.contains(TextElement.Typeface.BOLD)
        hyperlinkRun.isStrikeThrough = value.styles.contains(TextElement.Typeface.STRIKE)

        hyperlinkRun.setText(link)
    }

    private fun XWPFParagraph.addPicture(value: PictureElement) {
        textRun { addPicture(value) }
    }

    private fun XWPFDocument.addBorder(border: Document.Border, pageWidth: Int?, pageHeight: Int?) {
        val ctDocument = document
        val ctBody = ctDocument.body
        val ctSectPr = if (ctBody.isSetSectPr) ctBody.sectPr else ctBody.addNewSectPr()
        val ctPageSz = if (ctSectPr.isSetPgSz) ctSectPr.pgSz else ctSectPr.addNewPgSz()
        //paper size letter
        pageWidth?.let { ctPageSz.w = BigInteger.valueOf(pageWidth.toLong()) }
        pageHeight?.let { ctPageSz.h = BigInteger.valueOf(pageHeight.toLong()) }
        //page borders
        val ctPageBorders = if (ctSectPr.isSetPgBorders) ctSectPr.pgBorders else ctSectPr.addNewPgBorders()
        ctPageBorders.offsetFrom = STPageBorderOffset.PAGE
        for (b in 0..3) {
            val ctBorder = when(b) {
                0 -> if (ctPageBorders.isSetTop) ctPageBorders.top else ctPageBorders.addNewTop()
                1 -> if (ctPageBorders.isSetBottom) ctPageBorders.bottom else ctPageBorders.addNewBottom()
                2 -> if (ctPageBorders.isSetLeft) ctPageBorders.left else ctPageBorders.addNewLeft()
                else -> if (ctPageBorders.isSetRight) ctPageBorders.right else ctPageBorders.addNewRight()
            }
            ctBorder.setVal(STBorder.THREE_D_EMBOSS)

            ctBorder.sz = BigInteger.valueOf(border.size.toLong())
            ctBorder.space = BigInteger.valueOf(border.space.toLong())
            border.color?.let {
                //ctBorder.color = it
            }
        }
    }

    private fun Paragraph.Alignment.toAlignment(): ParagraphAlignment? {
        return when(this) {
            LEFT -> ParagraphAlignment.LEFT
            CENTER -> ParagraphAlignment.CENTER
            RIGHT -> ParagraphAlignment.RIGHT
            BOTH -> ParagraphAlignment.BOTH
        }
    }

    private fun XWPFDocument.paragraph(block: XWPFParagraph.() -> Unit) = block(createParagraph())

    private fun XWPFParagraph.textRun(block: XWPFRun.() -> Unit) = block(createRun())

    private fun XWPFParagraph.blankLines(count: Int) {
        textRun {
            for (i in 0 until count) addBreak()
        }
    }

    private fun XWPFDocument.table(block: XWPFTable.() -> Unit) = block(createTable())

    private fun XWPFTableCell.paragraph(block: XWPFParagraph.() -> Unit) = block(paragraphs.first())

    private fun XWPFTableRow.cell(index: Int, block: XWPFTableCell.() -> Unit) {
        if (tableCells.size > index) {
            block(getCell(index))
        } else {
            block(addNewTableCell())
        }
    }

    private fun XWPFTable.row(index: Int, block: XWPFTableRow.() -> Unit) {
        if (rows.size > index) {
            block(rows[index])
        } else {
            block(createRow())
        }
    }

    private fun XWPFRun.addPicture(value: PictureElement) {
        addPicture(
            value.inputStream,
            XWPFDocument.PICTURE_TYPE_PICT,
            value.name,
            Units.toEMU(value.width.toDouble()),
            Units.toEMU(value.height.toDouble())
        )
    }

    private fun Int.toHexString(): String = String.format(FORMAT_COLOR, (0xFFFFFF and this))

}
