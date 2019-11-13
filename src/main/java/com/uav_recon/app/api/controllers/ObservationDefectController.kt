package com.uav_recon.app.api.controllers

import com.uav_recon.app.api.repositories.*
import org.springframework.web.bind.annotation.RestController

@RestController
class ObservationDefectController(
        private val observationDefectRepository: ObservationDefectRepository,
        private val observationRepository: ObservationRepository,
        private val defectRepository: DefectRepository,
        private val conditionRepository: ConditionRepository,
        private val materialRepository: MaterialRepository
) {

}
