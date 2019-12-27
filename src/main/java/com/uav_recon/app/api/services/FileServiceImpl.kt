package com.uav_recon.app.api.services

import com.uav_recon.app.configurations.UavConfiguration
import org.springframework.stereotype.Service

@Service
class FileServiceImpl(configuration: UavConfiguration) : FileService {
    val service: FileService = if (configuration.files.useGoogle == "true") GoogleStorageFileService(
        configuration) else LocalStorageFileService(configuration)

    override fun save(path: String, bytes: ByteArray, format: String, drawables: String?): String {
        return service.save(path, bytes, format, drawables)
    }

    override fun delete(link: String) {
        service.delete(link)
    }

    override fun get(link: String, drawables: String?, withRect: Boolean): ByteArray {
        return service.get(link, drawables, withRect)
    }
}
