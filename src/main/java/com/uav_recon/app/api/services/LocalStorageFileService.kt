package com.uav_recon.app.api.services

import com.uav_recon.app.configurations.UavConfiguration
import org.springframework.stereotype.Service
import java.io.InputStream
import java.nio.file.Files
import java.nio.file.Paths

@Service
class LocalStorageFileService(private val configuration: UavConfiguration) : FileService {
    override fun save(inputStream: InputStream, uuid: String): String {
        Files.copy(inputStream, Paths.get(configuration.files.photosDir, uuid))
        return uuid
    }

    override fun delete(uuid: String) {
        Files.delete(Paths.get(configuration.files.photosDir, uuid))
    }
}
