package com.uav_recon.app.api.entities.requests.bridge

import com.fasterxml.jackson.annotation.JsonInclude
import java.io.Serializable

@JsonInclude(JsonInclude.Include.NON_NULL)
class StructureTypeDto(
    var id: String,
    var name: String,
    var numOfSpansEnabled: Boolean = false,
    var clockPositionEnabled: Boolean = false,
    var hideObservationType: Boolean = false,
    var hideStationMarker: Boolean = false,
    var deleted: Boolean = false
) : Serializable
