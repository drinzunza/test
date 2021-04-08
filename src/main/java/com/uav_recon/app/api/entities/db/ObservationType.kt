package com.uav_recon.app.api.entities.db

enum class ObservationType(val title: String, val letter: String) {
    CRITICAL("A – Critical", "A"),
    PRIORITY("B – Priority", "B"),
    ROUTINE("C – Routine", "C"),
    MONITOR("D – Monitor", "D")
}