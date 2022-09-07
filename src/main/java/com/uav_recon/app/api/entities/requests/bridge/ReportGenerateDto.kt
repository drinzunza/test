package com.uav_recon.app.api.entities.requests.bridge

import com.fasterxml.jackson.annotation.JsonInclude
import java.io.Serializable

@JsonInclude(JsonInclude.Include.NON_NULL)
data class ReportGenerateDto (
    val defectsOrder: HashMap<String, Int>,
    val maintenancesOrder: HashMap<String, Int>
) : Serializable