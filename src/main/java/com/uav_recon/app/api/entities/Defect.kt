package com.uav_recon.app.api.entities

interface Defect {
    val name: String
    val number: Int?
    val conditions: List<Condition>

    interface Condition {
        val description: String?
        val type: Type

        enum class Type {
            GOOD,
            FAIR,
            POOR,
            SEVERE
        }

        data class Simple(override val description: String?, override val type: Type) : Condition
    }

    data class Simple(
        override val name: String,
        override val number: Int?,
        override val conditions: List<Condition>
    ) : Defect
}