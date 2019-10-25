package com.uav_recon.app.api.entities.responses.bridge

import java.io.Serializable

data class DefectResponse(
    var id: Int,
    var name: String?,
    var number: Int?,
    var materialId: Int?
) : Serializable