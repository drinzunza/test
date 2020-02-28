package com.uav_recon.app.api.utils

import com.uav_recon.app.api.entities.db.Observation
import com.uav_recon.app.api.entities.db.ObservationDefect
import com.uav_recon.app.api.entities.db.StructuralType
import com.uav_recon.app.api.entities.db.Subcomponent

fun ObservationDefect.toStructural() = if (type == StructuralType.STRUCTURAL) this else null
fun ObservationDefect.toMaintenance() = if (type == StructuralType.MAINTENANCE) this else null

fun ObservationDefect.getSizeWithMeasureUnits(observation: Observation): String? {
    val subComponent = observation.subcomponent
    val measureUnit = subComponent?.measureUnit
    if (subComponent?.isEachMeasureUnit() == true) {
        return measureUnit?.toUpperCase()
    }
    return size?.let { size ->
        measureUnit?.let { unit -> "$size $unit" } ?: size
    }
}

fun Subcomponent.isEachMeasureUnit(): Boolean {
    return measureUnit.equals("ea", true)
}
