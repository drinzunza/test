package com.uav_recon.app.api.entities.requests.bridge

import java.io.Serializable

data class SyncAssetsRequest(
        val lastConditionId: Int?,
        val lastDefectId: Int?,
        val lastMaterialId: Int?,
        val lastStructuralComponentId: Int?,
        val lastStructureId: Int?,
        val lastStructureComponentId: Int?,
        val lastSubcomponentId: Int?
) : Serializable