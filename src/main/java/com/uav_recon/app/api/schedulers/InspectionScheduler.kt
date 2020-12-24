package com.uav_recon.app.api.schedulers

import com.uav_recon.app.api.entities.db.Inspection
import com.uav_recon.app.api.repositories.InspectionRepository
import com.uav_recon.app.api.services.InspectionService
import org.slf4j.LoggerFactory
import org.springframework.scheduling.annotation.Scheduled
import org.springframework.stereotype.Component
import java.util.*

@Component
class InspectionScheduler(
        private val inspectionRepository: InspectionRepository,
        private val inspectionService: InspectionService
) {
    private val logger = LoggerFactory.getLogger(InspectionScheduler::class.java)

    @Scheduled(initialDelay = 30000, fixedRate = 864000000)
    fun runGenerateSgrAndHealthIndex() {
        val timestamp = Date().time
        logger.info("scheduler started: runGenerateSgrAndHealthIndex")
        val inspections = mutableListOf<Inspection>()
        var countSgr = 0
        var countHi = 0
        inspectionRepository.findAll().forEachIndexed { index, inspection ->
            if ((index > 0 && index % 50 == 0) || index >= inspections.size - 1) {
                inspectionService.fillObjectsForSgrAndHealthIndex(inspections)
                countSgr += inspectionService.updateSgrRating(inspections)
                countHi += inspectionService.updateHealthIndex(inspections)
                inspections.clear()
            } else {
                inspections.add(inspection)
            }
        }
        logger.info("Saved $countSgr inspections with new sgr rating")
        logger.info("Saved $countHi observations with new health index")
        logger.info("scheduler stopped: runGenerateSgrAndHealthIndex ({} ms)", Date().time - timestamp)
    }
}