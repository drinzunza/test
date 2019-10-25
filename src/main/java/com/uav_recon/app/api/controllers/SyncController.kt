package com.uav_recon.app.api.controllers

import com.uav_recon.app.api.entities.requests.bridge.SyncAssetsRequest
import com.uav_recon.app.api.entities.responses.Response
import com.uav_recon.app.api.entities.responses.bridge.SyncAssetsResponse
import com.uav_recon.app.api.repositories.*
import com.uav_recon.app.api.utils.*
import com.uav_recon.app.configurations.ControllerConfiguration.VERSION
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RestController

@RestController
class SyncController(
        private val defectRepository: DefectRepository,
        private val conditionRepository: ConditionRepository,
        private val materialRepository: MaterialRepository,
        private val structuralComponentRepository: StructuralComponentRepository,
        private val structureRepository: StructureRepository,
        private val structureComponentRepository: StructureComponentRepository,
        private val subcomponentRepository: SubcomponentRepository
) {

    @PostMapping("$VERSION/syncAssets")
    fun syncAssets(@RequestBody request: SyncAssetsRequest): Response<SyncAssetsResponse> {
        val result = SyncAssetsResponse(
                request.lastConditionId?.let { conditionRepository.getValuesAfter(it).toList().toConditionResponseList() },
                request.lastDefectId?.let { defectRepository.getValuesAfter(it).toList().toDefectResponseList() },
                request.lastMaterialId?.let { materialRepository.getValuesAfter(it).toList().toMaterialResponseList() },
                request.lastStructuralComponentId?.let { structuralComponentRepository.getValuesAfter(it).toList() },
                request.lastStructureId?.let { structureRepository.getValuesAfter(it).toList() },
                request.lastStructureComponentId?.let { structureComponentRepository.getValuesAfter(it).toList().toStructureComponentResponseList() },
                request.lastSubcomponentId?.let { subcomponentRepository.getValuesAfter(it).toList().toSubcomponentResponseList() }
        )
        return result.response()
    }

    @PostMapping("$VERSION/syncInspections")
    fun syncInspections(): Response<Any> {
        return Response()
    }
}