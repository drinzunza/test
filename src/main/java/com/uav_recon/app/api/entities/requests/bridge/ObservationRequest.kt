package com.uav_recon.app.api.entities.requests.bridge

import java.io.Serializable

data class ObservationRequest(
    var code: String?,
    var inspectionId: Int?,
    var drawingNumber: String?,
    var roomNumber: String?,
    var spanNumber: String?,
    var locationDescription: String?,
    var structuralComponentId: Int?,
    var subcomponentId: Int?
) : Serializable