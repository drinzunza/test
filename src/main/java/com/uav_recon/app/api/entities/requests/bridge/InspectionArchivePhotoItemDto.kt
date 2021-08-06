package com.uav_recon.app.api.entities.requests.bridge

import java.io.InputStream

data class InspectionArchivePhotoItemDto(
    val stream: InputStream,
    val defectId: String,
    val index: Int
)
