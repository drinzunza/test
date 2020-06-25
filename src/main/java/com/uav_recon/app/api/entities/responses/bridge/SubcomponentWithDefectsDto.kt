package com.uav_recon.app.api.entities.responses.bridge

import com.fasterxml.jackson.annotation.JsonInclude
import java.io.Serializable
import javax.persistence.Column

@JsonInclude(JsonInclude.Include.NON_NULL)
data class SubcomponentWithDefectsDto(
        val id: String? = null,
        val name: String,
        val deleted: Boolean? = null,
        var number: Int? = null,
        var fdotBhiValue: Int? = null,
        var description: String? = null,
        var measureUnit: String? = null,
        var groupName: String? = null,
        val defects: List<DefectSaveDto>?
) : Serializable