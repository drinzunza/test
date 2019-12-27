package com.uav_recon.app.api.services

import com.google.cloud.storage.BlobId
import com.google.cloud.storage.BlobInfo
import com.google.cloud.storage.StorageOptions
import com.uav_recon.app.configurations.UavConfiguration

class GoogleStorageFileService(private val configuration: UavConfiguration) : FileService {
    private val storage = StorageOptions.getDefaultInstance().getService();
    private val linkPrefix = "https://storage.cloud.google.com/"

    override fun save(path: String, bytes: ByteArray, format: String, drawables: String?): String {
        storage.create(BlobInfo.newBuilder(configuration.files.gsBucket, path).build(), bytes)
        return "$linkPrefix$path"
    }

    override fun delete(link: String) {
        storage.delete(BlobId.of(configuration.files.gsBucket, link.replace(linkPrefix, "")))
    }

    override fun get(link: String, drawables: String?, withRect: Boolean): ByteArray {
        return storage.get(BlobId.of(configuration.files.gsBucket, link.replace(linkPrefix, ""))).getContent()
    }
}
