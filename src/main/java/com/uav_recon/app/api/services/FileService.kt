package com.uav_recon.app.api.services

import java.io.InputStream

interface FileService {
    fun save(path: String, bytes: ByteArray, format: String, drawables: String?): String
    fun save(userId: Int,
             inspectionUuid: String,
             observationUuid: String,
             defectUuid: String,
             photoUuid: String,
             drawables: String?,
             format: String,
             bytes: ByteArray): String {
        return save("$userId/$inspectionUuid/$defectUuid/$photoUuid.$format", bytes, format, drawables)
    }

    fun delete(link: String)
    fun get(link: String, drawables: String? = null, withRect: Boolean = false): InputStream
    fun getPath(link: String, drawables: String? = null, withRect: Boolean = false): String
}
