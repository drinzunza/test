package com.uav_recon.app.api.services.report

import com.uav_recon.app.api.entities.db.Report
import com.uav_recon.app.api.entities.db.StructuralType
import com.uav_recon.app.api.entities.requests.bridge.ReportDto
import com.uav_recon.app.api.entities.requests.bridge.ReportGenerateDto
import com.uav_recon.app.api.repositories.CompanyRepository
import com.uav_recon.app.api.repositories.InspectionRepository
import com.uav_recon.app.api.repositories.ReportRepository
import com.uav_recon.app.api.repositories.UserRepository
import com.uav_recon.app.api.services.Error
import com.uav_recon.app.api.services.FileService
import com.uav_recon.app.api.services.InspectionService
import com.uav_recon.app.api.services.ObservationDefectService
import com.uav_recon.app.api.services.report.document.DocumentFactory
import org.springframework.stereotype.Service
import java.text.SimpleDateFormat
import java.util.*

@Service
class ReportService(
        private val inspectionRepository: InspectionRepository,
        private val inspectionService: InspectionService,
        private val companyRepository: CompanyRepository,
        private val reportRepository: ReportRepository,
        private val userRepository: UserRepository,
        private val observationDefectService: ObservationDefectService,
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

    @Throws(Error::class)
    fun generate(userId: Int, inspectionId: String, dto: ReportGenerateDto): ReportDto {
        inspectionRepository.findFirstByUuidAndDeletedIsFalse(inspectionId)
                ?: throw Error(101, "Invalid inspection UUID")

        val user = userRepository.findFirstById(userId.toLong())
        if (user != null) {
            // check if defects and maintenances exist
            val inspection = inspectionService.getNotDeleted(user, inspectionId)
            val observationDefects = inspection.observations?.map { it.id }?.let {
                observationDefectService.findAllByObservationIdsAndNotDeleted(
                    it
                )
            }
            if (observationDefects != null) {
                val dtoTotalDefects = dto.defectsOrder.size + dto.maintenancesOrder.size
                if (dtoTotalDefects != observationDefects.size) {
                    throw Error(
                        400,
                        "Specify an order for exactly all defects and maintenances assigned to this inspection" +
                                "(Total defects and maintenances given is $dtoTotalDefects but should be ${observationDefects.size})"
                    )
                }

                val structuralDefects = observationDefects.filter { it.type == StructuralType.STRUCTURAL }
                dto.defectsOrder.forEach { (uuid, _) ->
                    if (!structuralDefects.any { it.uuid == uuid }) {
                        throw Error(400, "No defect with uuid $uuid is assigned to this inspection")
                    }
                }

                val maintenanceDefects = observationDefects.filter { it.type == StructuralType.MAINTENANCE }
                dto.maintenancesOrder.forEach { (uuid, _) ->
                    if (!maintenanceDefects.any { it.uuid == uuid }) {
                        throw Error(400, "No maintenance with uuid $uuid is assigned to this inspection")
                    }
                }
            }

            val company = user.companyId?.let { companyRepository.findFirstById(it) }
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

            val document = documentFactory.generateDocument(
                report,
                isInverse = company?.ratingInverse ?: false,
                defectsOrder = dto.defectsOrder,
                maintenanceOrder = dto.maintenancesOrder
            )
            documentWriter.writeDocument(document, fileService.getPath(link))

            val savedReport = reportRepository.save(report)
            return savedReport.toDto()
        } else {
           throw Error(18, "User not found")
        }
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
