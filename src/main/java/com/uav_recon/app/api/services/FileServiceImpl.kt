package com.uav_recon.app.api.services

import com.uav_recon.app.configurations.UavConfiguration
import org.springframework.stereotype.Service
import java.io.InputStream

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

    override fun get(link: String, drawables: String?, withRect: Boolean): InputStream {
        return service.get(link, drawables, withRect)
    }

    override fun getPath(link: String, drawables: String?, withRect: Boolean): String {
        return service.getPath(link, drawables, withRect)
    }
}
