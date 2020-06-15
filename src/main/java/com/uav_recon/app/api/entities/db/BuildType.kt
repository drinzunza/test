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

    fun toStructureTypePart(): StructureComponentType? {
        return when(this) {
            BRIDGES -> StructureComponentType.BRIDGES_AND_AERIAL_STRUCTURE
            TUNNELS -> StructureComponentType.SUBWAY_TUNNELS_USECTION
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
