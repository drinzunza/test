package com.uav_recon.app.api.utils

import com.uav_recon.app.api.entities.db.*

fun ObservationDefect.toStructural() = if (type == StructuralType.STRUCTURAL) this else null
fun ObservationDefect.toMaintenance() = if (type == StructuralType.MAINTENANCE) this else null

fun ObservationDefect.getSizeWithMeasureUnits(observation: Observation): String? {
    val subComponent = observation.subcomponent
    val measureUnit = subComponent?.measureUnit
    return size?.let { size ->
        measureUnit?.let { unit -> "$size $unit" } ?: size
    }
}

fun Subcomponent.isEachMeasureUnit(): Boolean {
    return measureUnit.equals("ea", true)
}

fun ObservationType.letter(): String {
    return when (this) {
        ObservationType.CRITICAL -> "A"
        ObservationType.PRIORITY -> "B"
        ObservationType.ROUTINE -> "C"
        ObservationType.MONITOR -> "D"
    }
}
