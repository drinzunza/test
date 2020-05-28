package com.uav_recon.app.api.entities.db

import java.io.Serializable
/*
    TODO добавить генератор
    При создании сущности (кроме структуры) обязательно должен приходить родительский элемент
 */
class EtagChange : Serializable {
    val defects = mutableListOf<String>()
    val conditions = mutableListOf<String>()
    val components = mutableListOf<String>()
    val subcomponents = mutableListOf<String>()
    val structures = mutableListOf<String>()
    val locationIds = mutableListOf<String>()
    val observationNames = mutableListOf<String>()
}