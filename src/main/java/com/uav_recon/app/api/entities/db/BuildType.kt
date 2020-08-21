package com.uav_recon.app.api.entities.db

enum class BuildType {
    FULL, BRIDGES, TUNNELS;

    fun toIdPart(): String? {
        return when(this) {
            BRIDGES -> "Bridge"
            TUNNELS -> "Tunnel"
            else -> null
        }
    }

    fun toStructureTypePart(): Long? {
        return when(this) {
            BRIDGES -> 1
            TUNNELS -> 2
            else -> null
        }
    }

    fun toLocationIdPart(): String? {
        return when(this) {
            BRIDGES -> "bridges"
            TUNNELS -> "tunnels"
            else -> null
        }
    }

    companion object {
        fun parse(type: String): BuildType {
            return when (type) {
                "bridges" -> BRIDGES
                "tunnels" -> TUNNELS
                else -> FULL
            }
        }
    }
}
