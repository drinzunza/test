package com.uav_recon.app.api.services.report

/*import com.uav_recon.app.api.beans.resources.Resources
import com.uav_recon.app.api.entities.db.Inspection
import com.uav_recon.app.api.services.FileStorageService
import com.uav_recon.app.api.utils.formatDate
import com.uav_recon.app.api.utils.runCommand
import com.uav_recon.app.configurations.FileStorageConfiguration
import java.io.FileOutputStream
import java.text.SimpleDateFormat
import java.util.*
import org.apache.poi.util.Units
//import org.apache.poi.xwpf.converter.pdf.PdfConverter
//import org.apache.poi.xwpf.converter.pdf.PdfOptions
import org.apache.poi.xwpf.usermodel.*
import org.springframework.stereotype.Service
import java.io.File
import java.io.FileInputStream
import org.slf4j.LoggerFactory

private val DATE_FORMAT = SimpleDateFormat("MM/dd/yy")

// for references see : https://www.tutorialspoint.com/apache_poi_word/apache_poi_word_tables.htm
@Service
class ReportGeneratorService(
        private val mapLoaderService: MapLoaderService,
        private val config: FileStorageConfiguration,
        private val fileStorageService: FileStorageService,
        private val resources: Resources) {

    private val logger = LoggerFactory.getLogger(ReportGeneratorService::class.java)

    init {
        // костылина, чтобы POI работал
        System.setProperty("org.apache.poi.javax.xml.stream.XMLInputFactory", "com.fasterxml.aalto.stax.InputFactoryImpl")
        System.setProperty("org.apache.poi.javax.xml.stream.XMLOutputFactory", "com.fasterxml.aalto.stax.OutputFactoryImpl")
        System.setProperty("org.apache.poi.javax.xml.stream.XMLEventFactory", "com.fasterxml.aalto.stax.EventFactoryImpl")
    }

    fun generateReport(inspection: Inspection): String {
        val doc = XWPFDocument(resources.template.inputStream()) // нужен для сохранения таблицы стилей
        createTitlePage(doc, inspection)
        doc.newPage()
        createGlobalsPage(doc, inspection)
        doc.newPage()
        createSummaryOfObservations(doc, inspection)
        doc.newPage()
//            for (obs in inspection.obs) {
        createObservationReport(doc, inspection/*, obs*/)
//        }

        return saveToFile(inspection, doc)
    }

    private fun saveToFile(inspection: Inspection, doc: XWPFDocument): String {
        val docxFileName = "report of ${inspection.structure.name}.docx"
        val pdfFileName = "report of ${inspection.structure.name}.pdf"
        val docxFile = fileStorageService.getFile(docxFileName)
        val pdfFile = fileStorageService.getFile(pdfFileName)

        doc.write(FileOutputStream(docxFile))
        //PdfConverter.getInstance().convert(doc, FileOutputStream(pdfFile), PdfOptions.getDefault()) // там в libs/ лежит джарник в котором я смерджил зависимости 2 либ
        //https://drive.google.com/open?id=1uOqzBLKL0VN0-3oWxGQVp3t7EaqqaAJ9 вот проект в котором генерировал

        logger.info(runCommand("pwd"))

        val command = "soffice --headless --convert-to pdf \"${docxFile.absolutePath}\""
        logger.info("Command: $command")
        val output = runCommand(command)
        logger.info("Out: $output")

        return pdfFileName
    }

    private fun createTitlePage(doc: XWPFDocument, inspection: Inspection) {
        doc.apply {
            paragraph {
                alignment = ParagraphAlignment.CENTER
                blankLines(3)
                textRun {
                    setText("Structure Type: ")
                }
                textRun {
                    isItalic = true
                    setText(inspection.structure.type)
                    addBreak()
                }
                blankLines(2)

                textRun {
                    setText("Structure ID: ")
                }
                textRun {
                    isItalic = true
                    setText("${inspection.structure.id}")
                    addBreak()
                }
                textRun {
                    setText("Caltrans Bridge No.: ")
                }
                textRun {
                    isItalic = true
                    setText("53 2400") // TODO: NO IDEA WHERE THIS COMES FROM
                    addBreak()
                }
                textRun {
                    setText("Post Mile: ")
                }
                textRun {
                    isItalic = true
                    setText("0.42") // TODO: NO IDEA WHERE THIS COMES FROM
                    addBreak()
                }
                textRun {
                    setText("Stationing: ")
                }
                textRun {
                    isItalic = true
                    setText("248+86 to 272+85") // TODO: NO IDEA WHERE THIS COMES FROM
                    addBreak()
                }
                blankLines(1)
                textRun {
                    fontSize = 9
                    isItalic = true
                    setText("Primary Owner: ")
                }
                textRun {
                    fontSize = 9
                    setText("Los Angeles Metropolitan Transportation Authority") // TODO: NO IDEA WHERE THIS COMES FROM
                    addBreak()
                }
                blankLines(1)
                textRun {
                    fontSize = 9
                    isItalic = true
                    setText("Structure Name: ")
                }
                textRun {
                    fontSize = 9
                    isItalic = true
                    setText(inspection.structure.name)
                    addBreak()
                }
                blankLines(1)
                textRun {
                    fontSize = 9
                    isItalic = true
                    setText("Structure Type: ")
                }
                textRun {
                    fontSize = 9
                    isItalic = true
                    setText(inspection.structure.type)
                    addBreak()
                }
                blankLines(6)
                textRun {
                    isBold = true
                    setText("Inspection Report Prepared")
                    addBreak(BreakType.TEXT_WRAPPING)
                    setText("by: ")
                }
                textRun {
                    setText("Alta Vista Solutions")
                    addBreak()
                }
                blankLines(3)
                textRun {
                    setText("Inspection Report No.: ")
                }
                textRun {
                    isItalic = true
                    setText("${inspection.id}")
                    addBreak()
                }
                textRun {
                    setText("Report Date: ")
                }
                textRun {
                    isItalic = true
                    setText("${Date().formatDate(DATE_FORMAT)}")
                    addBreak()
                }
                textRun {
                    setText("Inspection Date(s): ")
                }
                textRun {
                    isItalic = true
                    setText("${inspection.date.formatDate(DATE_FORMAT)}")
                    addBreak()
                }
            }
            paragraph {
                alignment = ParagraphAlignment.LEFT
                blankLines(6)
                textRun {
                    fontSize = 8
                    setText("Inspected by: Inspector Name")  // TODO: NO IDEA WHERE THIS COMES FROM
                }
            }
        }
    }

    private fun createGlobalsPage(doc: XWPFDocument, inspection: Inspection) {
        inspection.location.let {
            val inputStream = mapLoaderService.loadImage(it)
            doc.apply {
                paragraph {
                    alignment = ParagraphAlignment.CENTER
                    textRun {
                        if (inputStream != null) {
                            this.addPicture(
                                    inputStream,
                                    XWPFDocument.PICTURE_TYPE_PICT,
                                    resources.mockImagePath,
                                    Units.toEMU(450.0),
                                    Units.toEMU(250.0)
                            )
                        }
                        addBreak()
                    }
                }

                // for styling see http://svn.apache.org/repos/asf/poi/trunk/src/examples/src/org/apache/poi/xwpf/usermodel/examples/SimpleTable.java

                table {
                    row(0) {
                        cell(0) {
                            paragraph {
                                alignment = ParagraphAlignment.CENTER
                                textRun {
                                    isItalic = true
                                    isBold = true
                                    setText("Critical Findings – Prompt Action Required")
                                }
                            }
                        }
                    }
                }

                table {
                    row(0) {
                        cell(0) {
                            paragraph {
                                alignment = ParagraphAlignment.CENTER
                                textRun {
                                    isItalic = true
                                    isBold = true
                                    setText("Critical Findings – Prompt Action Required")
                                }
                            }
                        }
                        cell(1) {
                            paragraph {
                                alignment = ParagraphAlignment.CENTER
                                textRun {
                                    isItalic = true
                                    isBold = true
                                    setText("General Structure Condition Code")
                                }
                            }
                        }
                    }
                    row(1) {
                        cell(0) {
                            paragraph {
                                alignment = ParagraphAlignment.CENTER
                                textRun {
                                    isItalic = true
                                    setText("Structural: ${2}") // TODO: value from inspection
                                    addBreak()
                                    setText("Safety: ${0}") // TODO: value from inspection
                                    addBreak()
                                    setText("Other: ${"TBD"}") // TODO: value from inspection
                                }
                            }
                        }
                        cell(1) {
                            paragraph {
                                alignment = ParagraphAlignment.CENTER
                                textRun {
                                    isItalic = true
                                    setText("SGR Rating: ${75}%") // TODO: value from inspection
                                    addBreak()
                                    setText("Term Rating: ${3}") // TODO: value from inspection
                                }
                            }
                        }
                    }
                }

                table {
                    row(0) {
                        cell(0) {
                            paragraph {
                                alignment = ParagraphAlignment.CENTER
                                textRun {
                                    setText("General Inspection Summary")
                                }
                            }
                        }
                    }
                }

                paragraph {
                    textRun {
                        setText("User text regarding inspection summary.")
                    }
                }
            }
        }
    }

    private fun createSummaryOfObservations(doc: XWPFDocument, inspection: Inspection) {
        // nothing for now
    }

    private fun createObservationReport(doc: XWPFDocument, inspection: Inspection/*, observation: Observation*/) {
        doc.apply {
            paragraph {
                alignment = ParagraphAlignment.CENTER
                textRun {
                    isBold = true
                    isItalic = true
                    setText("Observation Report Summary")
                }
            }

            table {
                row(0) {
                    cell(0) {
                        verticalAlignment = XWPFTableCell.XWPFVertAlign.CENTER
                        paragraph {
                            alignment = ParagraphAlignment.LEFT
                            textRun {
                                isBold = true
                                setText("Span #: ")
                            }
                            textRun {
                                setText("${"PR205"}") // TODO: real value
                                addBreak()
                            }
                            textRun {
                                isBold = true
                                setText("Sub-component #: ")
                            }
                            textRun {
                                setText("${"Deck - Reinforced Concrete"}") // TODO: real value
                                addBreak()
                            }
                            blankLines(1)
                            textRun {
                                isBold = true
                                setText("Photo QTY's: ")
                            }
                            textRun {
                                setText("${"there is photo QTYS"}") // TODO: real value
                                addBreak()
                            }
                            blankLines(1)
                            textRun {
                                isBold = true
                                setText("Drawing Number: ")
                            }
                            textRun {
                                setText("${5}") // TODO: real value
                                addBreak()
                            }
                            textRun {
                                isBold = true
                                setText("Location: ")
                            }
                            textRun {
                                setText("${"123455.1234, 12451245.2363"}") // TODO: real value
                                addBreak()
                            }
                            blankLines(1)
                            textRun {
                                isBold = true
                                setText("Location description: ")
                            }
                            textRun {
                                setText("${"User notes"}") // TODO: real value
                                addBreak()
                            }
                            textRun {
                                isBold = true
                                setText("Room No.: ")
                            }
                            textRun {
                                setText("${"is Applicable"}") // TODO: real value
                            }

                        }
                    }
                    cell(1) {
                        verticalAlignment = XWPFTableCell.XWPFVertAlign.CENTER
                        paragraph {
                            alignment = ParagraphAlignment.RIGHT
                            textRun {
                                isBold = true
                                setText("Defect #: ")
                            }
                            textRun {
                                setText("${"PR205-1234125"}") // TODO: real value
                                addBreak()
                            }
                            textRun {
                                isBold = true
                                setText("Defect description: ")
                            }
                            textRun {
                                setText("${"Spall"}") // TODO: real value
                                addBreak()
                            }
                            textRun {
                                isBold = true
                                setText("Defect Condition State: ")
                            }
                            textRun {
                                setText("${3}") // TODO: real value
                                addBreak()
                            }
                            textRun {
                                isBold = true
                                setText("Inspection date: ")
                            }
                            textRun {
                                setText(inspection.date.formatDate(DATE_FORMAT))
                                addBreak()
                            }
                            textRun {
                                isBold = true
                                setText("Stationing: ")
                            }
                            textRun {
                                setText("${"XX-XXX"}") // TODO: real value
                            }
                        }
                    }
                }
            }

            paragraph {
                blankLines(4)
                alignment = ParagraphAlignment.CENTER
                textRun {
                    isItalic = true
                    isBold = true
                    setText("Inspection Photographs of Defects")
                }
            }

            table {
                width = 1000
                row(0) {
                    cell(0) {
                        paragraph {
                            textRun {
                                val file = File(resources.mockImagePath)
                                if (file.exists()) {
                                    addPicture(
                                            FileInputStream(file),
                                            XWPFDocument.PICTURE_TYPE_PICT,
                                            resources.mockImagePath,
                                            Units.toEMU(200.0),
                                            Units.toEMU(200.0)
                                    )
                                }
                            }
                        }

                    }
                    cell(1) {
                        paragraph {
                            textRun {
                                setText("  ")
                            }
                        }
                    }
                    cell(2) {
                        paragraph {
                            textRun {
                                val file = File(resources.mockImagePath)
                                if (file.exists()) {
                                    addPicture(
                                            FileInputStream(file),
                                            XWPFDocument.PICTURE_TYPE_PICT,
                                            resources.mockImagePath,
                                            Units.toEMU(200.0),
                                            Units.toEMU(200.0)
                                    )
                                }
                            }
                        }

                    }
                }
            }

            paragraph {
                blankLines(8)
                alignment = ParagraphAlignment.CENTER
                textRun {
                    isItalic = true
                    setText("Inspector's signature:                                                            Date:                        ")
                }
            }
        }
    }
}

private fun XWPFDocument.paragraph(block: XWPFParagraph.() -> Unit) {
    val paragraph = this.createParagraph()
    block(paragraph)
}

private fun XWPFDocument.newPage() {
    this.paragraph {
        textRun {
            addBreak(BreakType.PAGE)
        }
    }
}

private fun XWPFParagraph.textRun(block: XWPFRun.() -> Unit) {
    val run = this.createRun()
    block(run)
}

private fun XWPFParagraph.blankLines(count: Int) {
    this.textRun {
        for (i in 0 until count) {
            addBreak()
        }
    }
}

private fun XWPFDocument.table(block: XWPFTable.() -> Unit) {
    val table = this.createTable()
    block(table)
}

private fun XWPFTableCell.paragraph(block: XWPFParagraph.() -> Unit) {
    val paragraph = paragraphs.first()
    block(paragraph)
}

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
}*/