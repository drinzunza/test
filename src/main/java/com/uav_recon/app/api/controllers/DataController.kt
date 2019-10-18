package com.uav_recon.app.api.controllers

import com.uav_recon.app.api.entities.db.*
import com.uav_recon.app.api.entities.responses.Response
import com.uav_recon.app.api.repositories.*
import com.uav_recon.app.api.utils.response
import com.uav_recon.app.configurations.ControllerConfiguration.VERSION
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RestController

@RestController
class DataController(
        private val companyRepository: CompanyRepository,
        private val conditionRepository: ConditionRepository,
        private val defectRepository: DefectRepository,
        private val inspectionRepository: InspectionRepository,
        private val inspectorRepository: InspectorRepository,
        private val materialRepository: MaterialRepository,
        private val observationRepository: ObservationRepository,
        private val observationDefectRepository: ObservationDefectRepository,
        private val photoRepository: PhotoRepository,
        private val reportRepository: ReportRepository,
        private val structuralComponentRepository: StructuralComponentRepository,
        private val structureRepository: StructureRepository,
        private val subcomponentRepository: SubcomponentRepository) {

    @GetMapping("$VERSION/companies")
    fun companies(): Response<List<Company>> {
        return companyRepository.findAll().toMutableList().response()
    }

    @GetMapping("$VERSION/conditions")
    fun conditions(): Response<List<Condition>> {
        return conditionRepository.findAll().toMutableList().response()
    }

    @GetMapping("$VERSION/defects")
    fun defects(): Response<List<Defect>> {
        return defectRepository.findAll().toMutableList().response()
    }

    @GetMapping("$VERSION/inspections")
    fun inspections(): Response<List<Inspection>> {
        return inspectionRepository.findAll().toMutableList().response()
    }

    @GetMapping("$VERSION/inspectors")
    fun inspectors(): Response<List<Inspector>> {
        return inspectorRepository.findAll().toMutableList().response()
    }

    @GetMapping("$VERSION/materials")
    fun materials(): Response<List<Material>> {
        return materialRepository.findAll().toMutableList().response()
    }

    @GetMapping("$VERSION/observations")
    fun observations(): Response<List<Observation>> {
        return observationRepository.findAll().toMutableList().response()
    }

    @GetMapping("$VERSION/observation_defects")
    fun observationDefects(): Response<List<ObservationDefect>> {
        return observationDefectRepository.findAll().toMutableList().response()
    }

    @GetMapping("$VERSION/photos")
    fun photos(): Response<List<Photo>> {
        return photoRepository.findAll().toMutableList().response()
    }

    @GetMapping("$VERSION/reports")
    fun reports(): Response<List<Report>> {
        return reportRepository.findAll().toMutableList().response()
    }

    @GetMapping("$VERSION/structural_components")
    fun structuralComponents(): Response<List<StructuralComponent>> {
        return structuralComponentRepository.findAll().toMutableList().response()
    }

    @GetMapping("$VERSION/structures")
    fun structures(): Response<List<Structure>> {
        return structureRepository.findAll().toMutableList().response()
    }

    @GetMapping("$VERSION/subcomponents")
    fun subcomponents(): Response<List<Subcomponent>> {
        return subcomponentRepository.findAll().toMutableList().response()
    }
}