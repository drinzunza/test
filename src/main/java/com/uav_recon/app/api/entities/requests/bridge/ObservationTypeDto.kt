package com.uav_recon.app.api.entities.requests.bridge

import com.fasterxml.jackson.annotation.JsonInclude
import java.io.Serializable

@JsonInclude(JsonInclude.Include.NON_NULL)
class ObservationTypeDto(
        var name: String,
        var value: String,
        var letter: String
) : Serializable
