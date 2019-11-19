package com.uav_recon.app.api.services

import java.io.InputStream

interface FileService {
    fun save(inputStream: InputStream, uuid: String): String
    fun delete(uuid: String)
}
