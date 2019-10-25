package com.uav_recon.app.api.controllers

import com.uav_recon.app.api.entities.db.*
import com.uav_recon.app.api.entities.responses.Response
import com.uav_recon.app.api.entities.responses.bridge.*
import com.uav_recon.app.api.entities.responses.photo.PhotoResponse
import com.uav_recon.app.api.repositories.*
import com.uav_recon.app.api.utils.*
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
        private val structureComponentRepository: StructureComponentRepository,
        private val subcomponentRepository: SubcomponentRepository) {

    @GetMapping("$VERSION/companies")
    fun companies(): Response<List<Company>> {
        return companyRepository.findAll().toList().response()
    }

    @GetMapping("$VERSION/conditions")
    fun conditions(): Response<List<ConditionResponse>> {
        return conditionRepository.findAll().toList().toConditionResponseList().response()
    }

    @GetMapping("$VERSION/defects")
    fun defects(): Response<List<DefectResponse>> {
        return defectRepository.findAll().toList().toDefectResponseList().response()
    }

    @GetMapping("$VERSION/inspections")
    fun inspections(): Response<List<InspectionResponse>> {
        return inspectionRepository.findAll().toList().toInspectionResponseList().response()
    }

    @GetMapping("$VERSION/inspectors")
    fun inspectors(): Response<List<Inspector>> {
        return inspectorRepository.findAll().toList().response()
    }

    @GetMapping("$VERSION/materials")
    fun materials(): Response<List<MaterialResponse>> {
        return materialRepository.findAll().toList().toMaterialResponseList().response()
    }

    @GetMapping("$VERSION/observations")
    fun observations(): Response<List<ObservationResponse>> {
        return observationRepository.findAll().toList().toObservationResponseList().response()
    }

    @GetMapping("$VERSION/observation_defects")
    fun observationDefects(): Response<List<ObservationDefectResponse>> {
        return observationDefectRepository.findAll().toList().toObservationDefectResponseList().response()
    }

    @GetMapping("$VERSION/photos")
    fun photos(): Response<List<PhotoResponse>> {
        return photoRepository.findAll().toList().toPhotoResponseList().response()
    }

    @GetMapping("$VERSION/reports")
    fun reports(): Response<List<ReportResponse>> {
        return reportRepository.findAll().toList().toReportResponseList().response()
    }

    @GetMapping("$VERSION/structural_components")
    fun structuralComponents(): Response<List<StructuralComponent>> {
        return structuralComponentRepository.findAll().toList().response()
    }

    @GetMapping("$VERSION/structures")
    fun structures(): Response<List<Structure>> {
        return structureRepository.findAll().toList().response()
    }

    @GetMapping("$VERSION/structure_components")
    fun structureComponents(): Response<List<StructureComponentResponse>> {
        return structureComponentRepository.findAll().toList().toStructureComponentResponseList().response()
    }

    @GetMapping("$VERSION/subcomponents")
    fun subcomponents(): Response<List<SubcomponentResponse>> {
        return subcomponentRepository.findAll().toList().toSubcomponentResponseList().response()
    }
}