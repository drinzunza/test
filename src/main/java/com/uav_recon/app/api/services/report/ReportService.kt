package com.uav_recon.app.api.services.report

import com.uav_recon.app.api.entities.db.Report
import com.uav_recon.app.api.entities.requests.bridge.ReportDto
import com.uav_recon.app.api.repositories.InspectionRepository
import com.uav_recon.app.api.repositories.ReportRepository
import com.uav_recon.app.api.services.Error
import com.uav_recon.app.api.services.FileService
import com.uav_recon.app.api.services.report.document.DocumentFactory
import org.springframework.stereotype.Service
import java.text.SimpleDateFormat
import java.util.*

@Service
class ReportService(
        private val inspectionRepository: InspectionRepository,
        private val reportRepository: ReportRepository,
        private val documentWriter: DocumentWriter,
        private val documentFactory: DocumentFactory,
        private val fileService: FileService
) {

    fun Report.toDto() = ReportDto(
            id = id,
            link = link,
            date = createdAt!!
    )

    fun getLastReportDto(inspectionId: String): ReportDto {
        inspectionRepository.findFirstByUuidAndDeletedIsFalse(inspectionId)
                ?: throw Error(101, "Invalid inspection UUID")

        val reports = reportRepository.findAllByInspectionId(inspectionId)
        if (reports.isEmpty()) {
            throw Error(107, "Report not found")
        }
        return reports.last().toDto()
    }

    fun generate(userId: Int, inspectionId: String): ReportDto {
        inspectionRepository.findFirstByUuidAndDeletedIsFalse(inspectionId)
                ?: throw Error(101, "Invalid inspection UUID")

        val id = generateDisplayId(userId)
        val uuid = UUID.randomUUID().toString()
        val link = fileService.save("$userId/$inspectionId/$id.docx", ByteArray(0), "docx", null)
        val report = Report(
                id = id,
                uuid = uuid,
                link = link,
                inspectionId = inspectionId,
                createdBy = userId,
                updatedBy = userId
        )

        val document = documentFactory.generateDocument(report)
        documentWriter.writeDocument(document, fileService.getPath(link))

        val savedReport = reportRepository.save(report)
        return savedReport.toDto()
    }

    @Throws(Error::class)
    fun generateDisplayId(inspectorId: Int): String {
        val dateIdKey = SimpleDateFormat("MMddyyyy", Locale.US).format(Date())
        val displayIdRegexp = "%-$inspectorId-$dateIdKey"
        val reports = reportRepository.findAllByIdLike(displayIdRegexp)
        for (i in 1..5000) {
            val autoNum = String.format("%03d", i)
            val displayId = displayIdRegexp.replace("%-", "$autoNum-")
            if (reports.none { it.id == displayId }) {
                return displayId
            }
        }
        throw Error(246, "Cannot create unique report id")
    }
}
