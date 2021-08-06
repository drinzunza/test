package com.uav_recon.app.api.entities.requests.bridge

data class InspectionArchivePhotoDto (
    var structureName: String = "",
    var structureCode: String = "",
    var photos: List<InspectionArchivePhotoItemDto> = emptyList()
)
