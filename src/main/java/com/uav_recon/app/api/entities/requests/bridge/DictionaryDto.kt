package com.uav_recon.app.api.entities.requests.bridge

import com.fasterxml.jackson.annotation.JsonInclude
import com.uav_recon.app.api.entities.db.*
import java.io.Serializable

@JsonInclude(JsonInclude.Include.NON_NULL)
data class DictionaryDto(
        val conditions: List<Condition>,
        val defects: List<DefectDto>,
        val subComponents: List<SubcomponentDto>,
        val structuralComponents: List<ComponentDto>,
        val structures: List<StructureDto>
) : Serializable