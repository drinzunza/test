package com.uav_recon.app.api.services

import com.uav_recon.app.configurations.UavConfiguration
import org.apache.commons.lang3.StringUtils
import java.io.ByteArrayInputStream
import java.nio.file.Files
import java.nio.file.Paths
import java.nio.file.StandardCopyOption
import java.nio.file.StandardOpenOption

class LocalStorageFileService(private val configuration: UavConfiguration) : FileService {
    private val serverId = if (!StringUtils.isBlank(configuration.server.id)) "/${configuration.server.id}" else ""
    private val linkPrefix = "${configuration.server.host}$serverId/files/"

    override fun save(path: String, bytes: ByteArray): String {
        val absolutePath = Paths.get(configuration.files.root.replace("///", ""), path)
        val parentFile = absolutePath.toFile().parentFile
        if (!parentFile.exists()) {
            Files.createDirectories(parentFile.toPath())
        }
        if (absolutePath.toFile().exists()) {
            Files.copy(ByteArrayInputStream(bytes), absolutePath, StandardCopyOption.REPLACE_EXISTING)
        } else {
            Files.write(absolutePath, bytes, StandardOpenOption.CREATE_NEW)
        }
        return "$linkPrefix$path"
    }

    override fun get(link: String): ByteArray {
        return Files.readAllBytes(Paths.get(configuration.files.root, link.replace(linkPrefix, "")))
    }

    override fun delete(link: String) {
        Files.delete(Paths.get(configuration.files.root, link.replace(linkPrefix, "")))
    }
}
