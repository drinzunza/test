package com.uav_recon.app.api.entities.requests.bridge

data class InspectionArchivePhotoDto (
    var structureName: String? = null,
    var structureCode: String? = null,
    var photos: List<InspectionArchivePhotoItemDto> = emptyList()
)
