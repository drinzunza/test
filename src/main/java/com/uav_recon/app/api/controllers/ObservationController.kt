package com.uav_recon.app.api.controllers

import com.uav_recon.app.api.repositories.InspectionRepository
import com.uav_recon.app.api.repositories.ObservationRepository
import com.uav_recon.app.api.repositories.StructuralComponentRepository
import com.uav_recon.app.api.repositories.SubcomponentRepository
import org.springframework.web.bind.annotation.RestController

@RestController
class ObservationController(
        private val observationRepository: ObservationRepository,
        private val inspectionRepository: InspectionRepository,
        private val structuralComponentRepository: StructuralComponentRepository,
        private val subcomponentRepository: SubcomponentRepository
) {


}
