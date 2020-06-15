package com.uav_recon.app.api.entities.requests.bridge

import com.fasterxml.jackson.annotation.JsonInclude
import com.uav_recon.app.api.entities.db.Component
import com.uav_recon.app.api.entities.db.Defect
import com.uav_recon.app.api.entities.db.Subcomponent
import java.io.Serializable

@JsonInclude(JsonInclude.Include.NON_NULL)
data class DictionariesListDto(
        val components: List<Component>?,
        val subcomponents: List<Subcomponent>?,
        val defects: List<Defect>?
) : Serializable