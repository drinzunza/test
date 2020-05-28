package com.uav_recon.app.api.entities.responses.bridge

import com.fasterxml.jackson.annotation.JsonInclude
import com.uav_recon.app.api.entities.db.Defect
import com.uav_recon.app.api.entities.db.ObservationName
import java.io.Serializable

@JsonInclude(JsonInclude.Include.NON_NULL)
data class SubcomponentWithDefectsDto(
        val id: String,
        val name: String,
        val number: Int? = null,
        val fdotBhiValue: Int? = null,
        val description: String? = null,
        val measureUnit: String? = null,
        val componentId: String,
        val groupName: String? = null,
        val deleted: Boolean? = null,
        val defects: List<Defect>,
        var observationNames: List<ObservationName>
) : Serializable