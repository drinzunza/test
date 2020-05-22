package com.uav_recon.app.api.services

import com.uav_recon.app.api.entities.db.*
import com.uav_recon.app.api.entities.requests.bridge.ProjectDto
import com.uav_recon.app.api.entities.responses.bridge.SubcomponentHealthDto
import com.uav_recon.app.api.repositories.ComponentRepository
import com.uav_recon.app.api.repositories.StructureComponentRepository
import com.uav_recon.app.api.repositories.StructureRepository
import com.uav_recon.app.api.repositories.SubcomponentRepository
import com.uav_recon.app.api.services.report.document.main.DefectSummaryFields
import com.uav_recon.app.api.services.report.document.main.MainDocumentFactory
import org.springframework.stereotype.Service

@Service
class SubcomponentService(
        private val subcomponentRepository: SubcomponentRepository,
        private val structureRepository: StructureRepository,
        private val componentRepository: ComponentRepository,
        private val structureComponentRepository: StructureComponentRepository,
        private val mainDocumentFactory: MainDocumentFactory,
        private val observationService: ObservationService
) : BaseService() {

    /*fun Subcomponent.toDto(structures: List<Structure>, components: List<Component>, structureComponents: List<StructureComponent>): SubcomponentHealthDto {
        val component = components.firstOrNull { it.id == componentId }
        val structureIds = structureComponents.filter { it.componentId == component?.id }
    }

    fun listNotDeleted(user: User, companyId: Long?, structureId: String?): List<SubcomponentHealthDto> {
        val structures = user.companyId?.let { structureRepository.findAllByCompanyId(it) } ?: listOf()
        val structureComponents = structureComponentRepository.findAllByStructureIdIn(structures.map { it.id })
        val components = componentRepository.findAllByIdIn(structureComponents.map { it.componentId })
        val subcomponents = subcomponentRepository.findAllByComponentIdIn(components.map { it.id })

        val results = mutableListOf<Subcomponent>()
        subcomponents.forEach { subcomponent ->
            val component = components.firstOrNull { it.id == subcomponent.componentId }
            val structureIds = structureComponents.filter { it.componentId == component?.id }
        }

        return subcomponents.map { s -> s.toDto() }
    }*/

    fun createObservationSummary(inspection: Inspection): List<SubcomponentHealthDto> {
        inspection.observations
                ?.sortedBy { it.component?.name }
                ?.groupBy { it.component }
                ?.forEach {
                    val component = it.key ?: return@forEach
                    val list = it.value.map { observation ->
                        val spansCount = observation.getSpansCount(inspection.spansCount) ?: 0
                        DefectSummaryFields.ObservationData(observation, spansCount, observationService)
                    }
                    val totalHealthIndex: Double = list.sumByDouble { it.healthIndex } / list.size

                    DefectSummaryFields.buildHeaderRows(this, component.name, totalHealthIndex)
                    list.forEach {
                        row {
                            DefectSummaryFields.buildCells(this, it)
                        }
                    }
                }
    }
}