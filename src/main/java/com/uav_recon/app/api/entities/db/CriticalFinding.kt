package com.uav_recon.app.api.entities.db

enum class CriticalFinding(val finding: String) {
    STRUCTURAL_CRITICAL("Structural Critical"),
    SAFETY_CRITICAL("Safety Critical"),
    SAFETY_ITEM("Safety/Other")
}
