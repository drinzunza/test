package com.uav_recon.app.api.services.report.apache

import com.uav_recon.app.api.beans.resources.Resources
import com.uav_recon.app.api.services.FileStorageService
import com.uav_recon.app.api.services.report.DocumentWriter
import com.uav_recon.app.api.services.report.MapLoaderService
import com.uav_recon.app.api.services.report.document.models.Document
import com.uav_recon.app.api.services.report.document.models.Page
import com.uav_recon.app.api.services.report.document.models.body.Alignment
import com.uav_recon.app.api.services.report.document.models.body.Paragraph
import com.uav_recon.app.api.services.report.document.models.body.Table
import com.uav_recon.app.api.services.report.document.models.elements.*
import com.uav_recon.app.configurations.UavConfiguration
import org.apache.poi.util.Units
import org.apache.poi.xwpf.usermodel.*
import org.openxmlformats.schemas.wordprocessingml.x2006.main.*
import org.slf4j.LoggerFactory
import org.springframework.stereotype.Service
import java.io.File
import java.io.FileOutputStream
import java.math.BigInteger

private const val FORMAT_COLOR = "%06X"

@Service
class ApachePoiWriterService(private val resources: Resources) : DocumentWriter {

    private val logger = LoggerFactory.getLogger(ApachePoiWriterService::class.java)

    init {
        // POI doesn't work without this properties
        System.setProperty("org.apache.poi.javax.xml.stream.XMLInputFactory", "com.fasterxml.aalto.stax.InputFactoryImpl")
        System.setProperty("org.apache.poi.javax.xml.stream.XMLOutputFactory", "com.fasterxml.aalto.stax.OutputFactoryImpl")
        System.setProperty("org.apache.poi.javax.xml.stream.XMLEventFactory", "com.fasterxml.aalto.stax.EventFactoryImpl")
    }

    override fun writeDocument(document: Document, filePath: String) {
        val wordDocument = XWPFDocument(resources.template.inputStream()) // Need to save styles
        document.writeTo(wordDocument)
        FileOutputStream(filePath).use {
            wordDocument.write(it)
        }
    }

    private fun Document.writeTo(doc: XWPFDocument) {
        pages.forEachIndexed { index, page ->
            doc.addPage(this, page, index == pages.size - 1)
        }
    }

    private fun XWPFDocument.addPage(doc: Document, page: Page, isLastPage: Boolean) {
        page.elements.forEach { body ->
            when (body) {
                is Paragraph -> addParagraph(body)
                is Table -> addTable(body)
                else -> logger.error("Unsupported body type $body")
            }
        }

        addBorderAndOrientation(doc.border, page.orientation, doc.pageWidth, doc.pageHeight, isLastPage)
    }

    private fun XWPFDocument.addBorderAndOrientation(
            border: Document.Border?,
            orientation: Page.Orientation,
            pageWidth: Int,
            pageHeight: Int,
            isLastPage: Boolean
    ) {
        val section: CTSectPr = if (isLastPage) {
            // createParagraph add empty page at the end
            document.body.run {
                if (isSetSectPr) sectPr else addNewSectPr()
            }
        } else {
            createParagraph().ctp.run {
                val paragraphProperty = if (isSetPPr) pPr else addNewPPr()
                val section = if (paragraphProperty.isSetSectPr) paragraphProperty.sectPr else paragraphProperty.addNewSectPr()
                section.also { paragraphProperty.sectPr = it }
            }
        }

        val pageSize: CTPageSz = if (section.isSetPgSz) section.pgSz else section.addNewPgSz()
        when (orientation) {
            Page.Orientation.PORTRAIT -> {
                pageSize.orient = STPageOrientation.PORTRAIT
                pageSize.h = pageHeight.toBigInteger()
                pageSize.w = pageWidth.toBigInteger()
            }
            Page.Orientation.LANDSCAPE -> {
                pageSize.orient = STPageOrientation.LANDSCAPE
                pageSize.w = pageHeight.toBigInteger()
                pageSize.h = pageWidth.toBigInteger()
            }
        }

        border?.let {
            val pageBorders: CTPageBorders = if (section.isSetPgBorders) section.pgBorders else section.addNewPgBorders()
            pageBorders.addBorder(border)
        }
    }

    private fun CTPageBorders.addBorder(border: Document.Border) {
        this.offsetFrom = STPageBorderOffset.PAGE
        for (b in 0..3) {
            val ctBorder = when (b) {
                0 -> if (isSetTop) top else addNewTop()
                1 -> if (isSetBottom) bottom else addNewBottom()
                2 -> if (isSetLeft) left else addNewLeft()
                else -> if (isSetRight) right else addNewRight()
            }
            ctBorder.setVal(STBorder.THREE_D_EMBOSS)

            ctBorder.sz = border.size.toBigInteger()
            ctBorder.space = border.space.toBigInteger()
            border.color?.let { color ->
                ctBorder.color = color
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
                            verticalAlignment = when (cell.verticalAlignment) {
                                Alignment.START -> XWPFTableCell.XWPFVertAlign.TOP
                                Alignment.END -> XWPFTableCell.XWPFVertAlign.BOTTOM
                                else -> XWPFTableCell.XWPFVertAlign.CENTER
                            }
                        }
                    }
                }
            }
            applyMerges(value.merges)
        }
    }

    private fun XWPFTable.applyMerges(merges: List<Table.Merge>) {
        merges.forEach { merge ->
            when (merge.direction) {
                Table.Merge.Direction.HORIZONTAL -> {
                    val row = getRow(merge.mainAxisIndex)
                    val mergeStarter = CTHMerge.Factory.newInstance().apply {
                        `val` = STMerge.RESTART
                    }
                    val mergeFinisher = CTHMerge.Factory.newInstance().apply {
                        `val` = STMerge.CONTINUE
                    }
                    row.getCell(merge.startAxisIndex).ctTc.tcPr.hMerge = mergeStarter
                    for (i in (merge.startAxisIndex + 1)..merge.endAxisIndex) {
                        row.getCell(i).ctTc.tcPr.hMerge = mergeFinisher
                    }
                }
                Table.Merge.Direction.VERTICAL -> {
                    val mergeStarter = CTVMerge.Factory.newInstance().apply {
                        `val` = STMerge.RESTART
                    }
                    val mergeFinisher = CTVMerge.Factory.newInstance().apply {
                        `val` = STMerge.CONTINUE
                    }
                    getRow(merge.startAxisIndex).getCell(merge.mainAxisIndex).ctTc.tcPr.vMerge = mergeStarter
                    for (i in (merge.startAxisIndex + 1)..merge.endAxisIndex) {
                        getRow(i).getCell(merge.mainAxisIndex).ctTc.tcPr.vMerge = mergeFinisher
                    }
                }
            }
        }
    }

    private fun XWPFParagraph.addParagraph(value: Paragraph) {
        value.alignment?.let {
            alignment = when (it) {
                Alignment.START -> ParagraphAlignment.LEFT
                Alignment.CENTER -> ParagraphAlignment.CENTER
                Alignment.END -> ParagraphAlignment.RIGHT
                Alignment.BOTH -> ParagraphAlignment.BOTH
            }
        }
        value.list.forEach {
            when (it) {
                is LineFeedElement -> blankLines(it.count)
                is LinkTextElement -> addLinkText(it)
                is TextElement -> addText(it)
                is PictureElement -> addPicture(it)
                is IconLinkElement -> addIconLink(it)
                else -> logger.error("Unsupported element $it")
            }
        }
    }

    private fun XWPFParagraph.addText(value: TextElement) {
        textRun {
            isItalic = value.styles.contains(TextElement.Typeface.ITALIC)
            isBold = value.styles.contains(TextElement.Typeface.BOLD)
            isStrike = value.styles.contains(TextElement.Typeface.STRIKE)
            if (value.styles.contains(TextElement.Typeface.UNDERLINE)) underline = UnderlinePatterns.SINGLE
            value.textSize?.let { fontSize = it }
            value.textColor?.let { color = it }
            setText(value.text)
        }
    }

    private fun XWPFParagraph.addLinkText(value: LinkTextElement) {
        linkRun(value.text) {
            value.textColor?.let {
                color = it
            }
            value.textSize?.let { fontSize = it }
            underline = UnderlinePatterns.SINGLE

            isItalic = value.styles.contains(TextElement.Typeface.ITALIC)
            isBold = value.styles.contains(TextElement.Typeface.BOLD)
            isStrike = value.styles.contains(TextElement.Typeface.STRIKE)
            setText(value.text)
        }
    }

    private fun XWPFParagraph.addPicture(value: PictureElement) {
        textRun { addPicture(value) }
    }

    private fun XWPFParagraph.addIconLink(value: IconLinkElement) {
        linkRun(value.link) {
            val stream = resources.getData(value.name)?.inputStream()
            addPicture(
                stream,
                XWPFDocument.PICTURE_TYPE_PNG,
                value.link,
                Units.toEMU(value.size),
                Units.toEMU(value.size)
            )
        }
    }

    private fun XWPFParagraph.linkRun(link: String?, block: XWPFHyperlinkRun.() -> Unit) {
        val rId = part.packagePart.addExternalRelationship(link, XWPFRelation.HYPERLINK.relation).id
        val cthyperLink = ctp.addNewHyperlink()
        cthyperLink.id = rId
        cthyperLink.addNewR()
        val hyperlinkRun = XWPFHyperlinkRun(cthyperLink, cthyperLink.getRArray(0), this)
        hyperlinkRun.block()
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
