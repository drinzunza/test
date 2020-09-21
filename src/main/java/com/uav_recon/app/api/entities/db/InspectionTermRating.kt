package com.uav_recon.app.api.entities.db

enum class InspectionTermRating(val value: Double) {
    EXCELLENT(5.0),
    GOOD(4.0),
    ADEQUATE(3.0),
    MARGINAL(2.0),
    POOR(1.0)
}

fun Double.toInspectionTermRating() = when (this) {
    5.0 -> InspectionTermRating.EXCELLENT
    4.0 -> InspectionTermRating.GOOD
    3.0 -> InspectionTermRating.ADEQUATE
    2.0 -> InspectionTermRating.MARGINAL
    1.0 -> InspectionTermRating.POOR
    else -> null
}