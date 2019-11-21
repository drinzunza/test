package com.uav_recon.app.api.services

import com.google.cloud.storage.BlobId
import com.google.cloud.storage.BlobInfo
import com.google.cloud.storage.StorageOptions
import com.uav_recon.app.configurations.UavConfiguration

class GoogleStorageFileService(private val configuration: UavConfiguration) : FileService {
    val storage = StorageOptions.getDefaultInstance().getService();
    override fun save(path: String, bytes: ByteArray): String {
        storage.create(BlobInfo.newBuilder(configuration.files.gsBucket, path).build(), bytes)
        return "https://storage.cloud.google.com/$path"
    }

    override fun delete(path: String) {
        storage.delete(BlobId.of(configuration.files.gsBucket, path))
    }

    override fun get(path: String): ByteArray {
        return storage.get(BlobId.of(configuration.files.gsBucket, path)).getContent()
    }
}
