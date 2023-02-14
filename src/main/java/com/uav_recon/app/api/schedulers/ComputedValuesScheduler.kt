//package com.uav_recon.app.api.schedulers
//
//import com.uav_recon.app.api.repositories.*
//import com.uav_recon.app.api.services.ObservationService
//import com.uav_recon.app.api.services.ObservationStructureSubdivisionService
//import com.uav_recon.app.api.services.StructureSubdivisionService
//import org.slf4j.LoggerFactory
//import org.springframework.scheduling.annotation.Scheduled
//import org.springframework.stereotype.Component
//import java.text.SimpleDateFormat
//import java.util.Date
//
//
//@Component
//class ComputedValuesScheduler(
//    private val inspectionRepository: InspectionRepository,
//    private val observationRepository: ObservationRepository,
//    private val observationDefectRepository: ObservationDefectRepository,
//    private val structureSubdivisionRepository: StructureSubdivisionRepository,
//    private val observationStructureSubdivisionRepository: ObservationStructureSubdivisionRepository,
//    private val conditionRepository: ConditionRepository,
//    private val observationService: ObservationService,
//    private val observationStructureSubdivisionService: ObservationStructureSubdivisionService,
//    private val structureSubdivisionService: StructureSubdivisionService
//) {
//    private val logger = LoggerFactory.getLogger(ComputedValuesScheduler::class.java)
//    private val dateFormat = SimpleDateFormat("HH:mm:ss")
//
//    // This will run the computeValues method once daily
//    @Scheduled(cron = "0 0 0 * * *")
//    fun computeValues() {
//        logger.info("The time is now {}", dateFormat.format(Date()))
//
//        val allInspections = inspectionRepository
//            .findAll()
//            .filter { it.deleted == false }
//
//        logger.info("Start processing of ${allInspections.size} inspections")
//
//        allInspections.parallelStream().forEach { inspection ->
//            run {
//                val inspectionId = inspection.uuid
//
//                val inspectionObservations = observationRepository
//                    .findAllByInspectionIdAndDeletedIsFalse(inspectionId)
//                inspectionObservations.forEach { observation ->
//                    run {
//                        val defects = observationDefectRepository
//                            .findAllByObservationIdAndDeletedIsFalse(observation.uuid)
//                        val conditions = conditionRepository.findAllByIdIn(defects.map { it.conditionId ?: "" })
//                        defects.parallelStream().forEach { defect ->
//                            defect.condition = conditions.firstOrNull { it.id == defect.conditionId }
//                        }
//                        observation.defects = defects
//                        observation.computedHealthIndex =
//                            observationService.calculateObservationHealthIndex(observation)
//                        observationRepository.save(observation)
//                    }
//                }
//
//                val structureSubdivisions = structureSubdivisionRepository
//                    .findAllByInspectionId(inspectionId)
//                structureSubdivisions.forEach { structureSubdivision ->
//                    run {
//                        val observationStructureSubdivisions = observationStructureSubdivisionRepository
//                            .findAllByStructureSubdivisionId(structureSubdivision.uuid)
//                        observationStructureSubdivisions.forEach { observationStructureSubdivision ->
//                            run {
//                                observationStructureSubdivision.computedHealthIndex =
//                                    observationStructureSubdivisionService
//                                        .calculateSubdivisionObservationHealthIndex(
//                                            observationStructureSubdivision
//                                        )
//                                observationStructureSubdivisionRepository.save(observationStructureSubdivision)
//                            }
//                        }
//
//                        structureSubdivision.computedSgrRating = structureSubdivisionService
//                            .calculateSubdivisionSgr(structureSubdivision)
//                        structureSubdivisionRepository.save(structureSubdivision)
//                    }
//                }
//                logger.info("Done processing inspection: ${inspection.uuid}")
//            }
//        }
//
//        logger.info("All ${allInspections.size} inspections has been processed.")
//    }
//}
