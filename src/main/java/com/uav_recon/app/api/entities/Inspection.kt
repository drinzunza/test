package com.uav_recon.app.api.entities

import java.io.Serializable
import java.util.*

class Inspection(
        val id: Long = 0,
        val date: Date = Date(),
        val location: Location = Location(),
        val structure: Structure = Structure()
) : Serializable