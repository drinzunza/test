package com.uav_recon.app.api.services

import java.io.InputStream

class GoogleStorageFileService : FileService {
    val storage = StorageOptions.getDefaultInstance().getService();
    override fun save(inputStream: InputStream, uuid: String): String {
        return ""
    }

    override fun delete(uuid: String) {

    }
}
