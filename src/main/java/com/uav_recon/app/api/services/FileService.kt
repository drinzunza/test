package com.uav_recon.app.api.services

interface FileService {
    fun save(path: String, bytes: ByteArray): String
    fun save(userId: Int,
             inspectionUuid: String,
             observationUuid: String,
             defectUuid: String,
             photoUuid: String,
             format: String,
             bytes: ByteArray): String {
        return save("$userId/$inspectionUuid/$defectUuid/$photoUuid.$format", bytes)
    }

    fun delete(link: String)
    fun get(link: String): ByteArray
}
