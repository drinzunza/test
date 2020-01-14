package com.uav_recon.app.api.entities.db

enum class ConditionType(val title: String, val csWeight: Double) {
    GOOD("CS-1", 1.0),
    FAIR("CS-2", 0.5),
    POOR("CS-3", 0.25),
    SEVERE("CS-4", 0.0);

    companion object {
        val LIST_EXCLUDING_GOOD = values().toList() - GOOD
    }
}