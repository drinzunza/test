package com.uav_recon.app.api.entities

import java.io.Serializable

class Structure(
    val id: Long = 0,
    val name: String = "",
    val type: String = ""
) : Serializable