package com.uav_recon.app.entities

interface SubComponent {

    val name: String
    val materials: List<com.uav_recon.app.api.entities.Material>

    fun getElements(value: Material): List<com.uav_recon.app.api.entities.Material>

    interface Material {

        val name: String?

    }

}