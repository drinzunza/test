package com.uav_recon.app.api.entities

interface Structure {
    val id: Long
    val name: String
    val type: Type
    val components: List<StructuralComponent>

    enum class Type(val title: Int) {
        BRIDGES_AND_AERIAL_STRUCTURE(0),
        RETAINING_WALLS_AND_CONCENTRATE_TRACKS(1),
        SUBWAY_STATIONS_AND_AERIAL_STATIONS(2)
    }
}