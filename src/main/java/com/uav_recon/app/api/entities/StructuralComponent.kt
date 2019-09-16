package com.uav_recon.app.api.entities

import com.uav_recon.app.entities.SubComponent

interface StructuralComponent {
    val name: String
    val subComponents: List<SubComponent>
}