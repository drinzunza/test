package com.uav_recon.app.api.entities.requests.bridge

import com.fasterxml.jackson.annotation.JsonInclude
import com.uav_recon.app.api.entities.db.*
import java.io.Serializable

@JsonInclude(JsonInclude.Include.NON_NULL)
data class DictionariesDto(
        val components: List<Component>,
        val subcomponents: List<Subcomponent>,
        val defects: List<Defect>,
        val observationNames: List<ObservationName>,
        val conditions: List<Condition>,
        val locationIds: List<LocationIdDto>
) : Serializable