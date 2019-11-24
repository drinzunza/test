package com.uav_recon.app.api.services

import com.uav_recon.app.configurations.UavConfiguration
import org.springframework.stereotype.Service

@Service
class FileServiceImpl(configuration: UavConfiguration) : FileService {
    val service: FileService = if (configuration.files.useGoogle == "true") GoogleStorageFileService(
        configuration) else LocalStorageFileService(configuration)

    override fun save(path: String, bytes: ByteArray): String {
        return service.save(path, bytes)
    }

    override fun delete(path: String) {
        service.delete(path)
    }

    override fun get(path: String): ByteArray {
        return service.get(path)
    }

}
