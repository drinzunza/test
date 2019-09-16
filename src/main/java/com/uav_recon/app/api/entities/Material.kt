package com.uav_recon.app.api.entities

interface Material {

    val name: String
    val description: String?
    val measureUnit: String?
    val defects: List<Defect>

    data class Simple(
        override val name: String,
        override val description: String?,
        override val measureUnit: String?,
        override val defects: List<Defect>
    ) : Material
}