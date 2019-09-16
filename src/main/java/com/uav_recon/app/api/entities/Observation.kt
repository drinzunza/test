package com.uav_recon.app.api.entities

interface Observation {
    val id: String
    val defects: List<Defect>
}