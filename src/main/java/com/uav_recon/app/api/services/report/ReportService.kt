package com.uav_recon.app.api.services.report

import com.uav_recon.app.api.entities.db.Report
import com.uav_recon.app.api.entities.requests.bridge.ReportDto
import com.uav_recon.app.api.repositories.InspectionRepository
import com.uav_recon.app.api.repositories.ReportRepository
import com.uav_recon.app.api.services.FileService
import com.uav_recon.app.api.services.report.document.DocumentFactory
import com.uav_recon.app.api.services.Error
import org.springframework.stereotype.Service
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
            id = uuid,
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

        val uuid = UUID.randomUUID().toString()
        val link = fileService.save("$userId/$inspectionId/$uuid.docx", ByteArray(0), "docx", null)
        val report = Report(
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
}
