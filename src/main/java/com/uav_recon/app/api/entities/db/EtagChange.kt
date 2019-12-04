package com.uav_recon.app.api.entities.db

import java.io.Serializable

class EtagChange : Serializable {
    val defects: List<String> = mutableListOf()
    val conditions: List<String> = mutableListOf()
    val components: List<String> = mutableListOf()
    val subcomponents: List<String> = mutableListOf()
    val structures: List<String> = mutableListOf()
}