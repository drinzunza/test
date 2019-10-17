package com.uav_recon.app.api.services.report

import be.quodlibet.boxable.BaseTable
import be.quodlibet.boxable.HorizontalAlignment
import be.quodlibet.boxable.VerticalAlignment
import be.quodlibet.boxable.line.LineStyle
import com.uav_recon.app.api.beans.resources.Resources
import com.uav_recon.app.api.entities.db.Inspection
import com.uav_recon.app.api.services.FileStorageService
import com.uav_recon.app.configurations.FileStorageConfiguration
import org.apache.pdfbox.pdmodel.PDDocument
import org.apache.pdfbox.pdmodel.PDPage
import org.apache.pdfbox.pdmodel.PDPageContentStream
import org.apache.pdfbox.pdmodel.common.PDRectangle
import org.apache.pdfbox.pdmodel.font.PDType1Font
import org.apache.pdfbox.pdmodel.graphics.image.PDImageXObject
import org.slf4j.LoggerFactory
import org.springframework.stereotype.Service
import java.awt.Color
import java.io.IOException

@Service
class ReportService(private val mapLoaderService: MapLoaderService,
                    private val config: FileStorageConfiguration,
                    private val fileStorageService: FileStorageService,
                    private val resources: Resources) {

    private val logger = LoggerFactory.getLogger(ReportGeneratorService::class.java)

    fun generateReport(inspection: Inspection): String {
        val document = PDDocument()
        //createTitlePage(document, addPage(document), inspection)
        createExample(document, null, inspection)
        createExample2(document, null, inspection)
        return saveToFile(document, inspection)
    }

    fun createTitlePage(document: PDDocument, page: PDPage, inspection: Inspection) {
        val contentStream = PDPageContentStream(document, page)

        contentStream.setFont(PDType1Font.COURIER, 12.0f)
        contentStream.beginText()
        contentStream.showText("Structure Type: ")
        contentStream.setFont(PDType1Font.COURIER_OBLIQUE, 12.0f)
        contentStream.showText(inspection.structure.type)
        contentStream.endText()
        contentStream.beginText()
        contentStream.showText("Structure ID: ")
        contentStream.setFont(PDType1Font.COURIER_OBLIQUE, 12.0f)
        contentStream.showText("${inspection.structure.id}")
        contentStream.endText()

        contentStream.close()
    }

    fun createExample(document: PDDocument, page: PDPage?, inspection: Inspection) {
        val page1 = PDPage(PDRectangle.A4)
        // PDRectangle.LETTER and others are also possible
        val rect = page1.mediaBox
        // rect can be used to get the page width and height
        document.addPage(page1)

        // Create a new font object selecting one of the PDF base fonts
        val fontPlain = PDType1Font.HELVETICA
        val fontBold = PDType1Font.HELVETICA_BOLD
        val fontItalic = PDType1Font.HELVETICA_OBLIQUE
        val fontMono = PDType1Font.COURIER

        // Start a new content stream which will hold the content that's about to be created
        var cos = PDPageContentStream(document, page1)

        var line = 0

        // Define a text content stream using the selected font, move the cursor and draw some text
        cos.beginText()
        cos.setFont(fontPlain, 12f)
        cos.newLineAtOffset(100f, rect.height - 50 * ++line)
        cos.showText("Hello World")
        cos.endText()

        cos.beginText()
        cos.setFont(fontItalic, 12f)
        cos.newLineAtOffset(100f, rect.height - 50 * ++line)
        cos.showText("Italic")
        cos.endText()

        cos.beginText()
        cos.setFont(fontBold, 12f)
        cos.newLineAtOffset(100f, rect.height - 50 * ++line)
        cos.showText("Bold")
        cos.endText()

        cos.beginText()
        cos.setFont(fontMono, 12f)
        cos.setNonStrokingColor(Color.BLUE)
        cos.newLineAtOffset(100f, rect.height - 50 * ++line)
        cos.showText("Monospaced blue")
        cos.endText()

        // Make sure that the content stream is closed:
        cos.close()

        val page2 = PDPage(PDRectangle.A4)
        document.addPage(page2)
        cos = PDPageContentStream(document, page2)

        // draw a red box in the lower left hand corner
        cos.setNonStrokingColor(Color.RED)
        cos.addRect(10f, 10f, 100f, 100f)
        cos.fill()

        // add two lines of different widths
        cos.setLineWidth(1f)
        cos.moveTo(200f, 250f)
        cos.lineTo(400f, 250f)
        cos.closeAndStroke()
        cos.setLineWidth(5f)
        cos.moveTo(200f, 300f)
        cos.lineTo(400f, 300f)
        cos.closeAndStroke()

        // add an image
        try {
            val ximage = PDImageXObject.createFromFile(resources.mockImagePath, document)
            val scale = 0.5f // alter this value to set the image size
            cos.drawImage(ximage, 100f, 400f, ximage.width * scale, ximage.height * scale)
        } catch (ioex: IOException) {
            println("No image for you")
        }
        // close the content stream for page 2
        cos.close()
    }

    fun createExample2(document: PDDocument, page8: PDPage?, inspection: Inspection) {
        val page = PDPage(PDRectangle.A4)
        // PDRectangle.LETTER and others are also possible
        val rect = page.mediaBox
        // rect can be used to get the page width and height
        document.addPage(page)

        // Create a new font object selecting one of the PDF base fonts
        val fontPlain = PDType1Font.HELVETICA
        val fontBold = PDType1Font.HELVETICA_BOLD
        val fontItalic = PDType1Font.HELVETICA_OBLIQUE
        val fontMono = PDType1Font.COURIER

        // Start a new content stream which will "hold" the to be created content
        val cos = PDPageContentStream(document, page)

        //Dummy Table
        val margin = 50f
        // starting y position is whole page height subtracted by top and bottom margin
        val yStartNewPage = page.mediaBox.height - 2 * margin
        // we want table across whole page width (subtracted by left and right margin ofcourse)
        val tableWidth = page.mediaBox.width - 2 * margin

        val drawContent = true
        val yStart = yStartNewPage
        val bottomMargin = 70f
        // y position is your coordinate of top left corner of the table
        val yPosition = 550f

        val table = BaseTable(yPosition, yStartNewPage,
                bottomMargin, tableWidth, margin, document, page, true, drawContent)

        // the parameter is the row height
        val headerRow = table.createRow(50.0f)
        // the first parameter is the cell width
        var cell = headerRow.createCell(100.0f, "Header")
        cell.font = fontBold
        cell.fontSize = 20.0f
        // vertical alignment
        cell.valign = VerticalAlignment.MIDDLE
        // border style
        cell.setTopBorderStyle(LineStyle(Color.BLACK, 10.0f))
        table.addHeaderRow(headerRow)

        var row = table.createRow(20.0f)
        cell = row.createCell(30.0f, "black left plain")
        cell.fontSize = 15.0f
        cell = row.createCell(70.0f, "black left bold")
        cell.fontSize = 15.0f
        cell.font = fontBold

        row = table.createRow(20.0f)
        cell = row.createCell(50.0f, "red right mono")
        cell.textColor = Color.RED
        cell.fontSize = 15.0f
        cell.font = fontMono
        // horizontal alignment
        cell.align = HorizontalAlignment.RIGHT
        cell.setBottomBorderStyle(LineStyle(Color.RED, 5.0f))
        cell = row.createCell(50.0f, "green centered italic")
        cell.textColor = Color.GREEN
        cell.fontSize = 15.0f
        cell.font = fontItalic
        cell.align = HorizontalAlignment.CENTER
        cell.setBottomBorderStyle(LineStyle(Color.GREEN, 5.0f))

        row = table.createRow(20.0f)
        cell = row.createCell(40.0f, "rotated")
        cell.fontSize = 15.0f
        // rotate the text
        cell.isTextRotated = true
        cell.align = HorizontalAlignment.RIGHT
        cell.valign = VerticalAlignment.MIDDLE
        // long text that wraps
        cell = row.createCell(30.0f, "long text long text long text long text long text long text long text")
        cell.fontSize = 12.0f
        // long text that wraps, with more line spacing
        cell = row.createCell(30.0f, "long text long text long text long text long text long text long text")
        cell.fontSize = 12.0f
        cell.lineSpacing = 2.0f

        table.draw()

        val tableHeight = table.headerAndDataHeight
        println("tableHeight = $tableHeight")

        // close the content stream
        cos.close()
    }

    private fun addPage(document: PDDocument): PDPage {
        val page = PDPage(PDRectangle.A4)
        document.addPage(page)
        return page
    }

    private fun saveToFile(document: PDDocument, inspection: Inspection): String {
        val pdfFileName = "report of ${inspection.structure.name}.pdf"
        val pdfFile = fileStorageService.getFile(pdfFileName)
        document.save(pdfFile)
        document.close()
        return pdfFileName
    }
}