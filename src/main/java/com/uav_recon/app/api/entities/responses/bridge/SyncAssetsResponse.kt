package com.uav_recon.app.api.entities.responses.bridge

import com.uav_recon.app.api.entities.db.*
import java.io.Serializable

data class SyncAssetsResponse(
        val conditions: List<ConditionResponse>?,
        val defects: List<DefectResponse>?,
        val materials: List<MaterialResponse>?,
        val structuralComponents: List<StructuralComponent>?,
        val structures: List<Structure>?,
        val structureComponents: List<StructureComponentResponse>?,
        val subcomponents: List<SubcomponentResponse>?
) : Serializable