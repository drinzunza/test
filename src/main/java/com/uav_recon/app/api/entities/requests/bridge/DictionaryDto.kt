package com.uav_recon.app.api.entities.requests.bridge

import com.fasterxml.jackson.annotation.JsonInclude
import com.uav_recon.app.api.entities.db.*
import java.io.Serializable

@JsonInclude(JsonInclude.Include.NON_NULL)
data class DictionaryDto(
        var conditions: List<Condition>,
        var defects: List<DefectDto>,
        var subComponents: List<SubcomponentDto>,
        var structuralComponents: List<ComponentDto>,
        var structures: List<StructureDto>,
        var locationIds: List<LocationIdDto>,
        var observationNames: List<ObservationName>
) : Serializable