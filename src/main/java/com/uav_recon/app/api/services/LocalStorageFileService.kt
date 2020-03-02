package com.uav_recon.app.api.services

import com.uav_recon.app.api.entities.db.Rect
import com.uav_recon.app.api.utils.saveWithRect
import com.uav_recon.app.configurations.UavConfiguration
import org.apache.commons.lang3.StringUtils
import org.slf4j.LoggerFactory
import java.io.ByteArrayInputStream
import java.io.File
import java.io.FileInputStream
import java.io.InputStream
import java.nio.file.*

class LocalStorageFileService(private val configuration: UavConfiguration) : FileService {
    private val logger = LoggerFactory.getLogger(LocalStorageFileService::class.java)
    private val serverId = if (!StringUtils.isBlank(configuration.server.id)) "/${configuration.server.id}" else ""
    private val linkPrefix = "${configuration.server.host}$serverId/files/"

    override fun save(path: String, bytes: ByteArray, format: String, drawables: String?): String {
        val absolutePath = getAbsolutePath(path, format, FileService.FileType.NORMAL)
        val absolutePathWithRect = getAbsolutePath(path, format, FileService.FileType.WITH_RECT)
        val absolutePathWithRectThumb = getAbsolutePath(path, format, FileService.FileType.WITH_RECT_THUMB)

        val parentFile = absolutePath.toFile().parentFile
        if (!parentFile.exists()) {
            Files.createDirectories(parentFile.toPath())
        }
        if (absolutePath.toFile().exists()) {
            Files.copy(ByteArrayInputStream(bytes), absolutePath, StandardCopyOption.REPLACE_EXISTING)
        } else {
            Files.write(absolutePath, bytes, StandardOpenOption.CREATE_NEW)
        }
        generateRectImages(bytes, getRect(drawables), absolutePathWithRect.toFile(), absolutePathWithRectThumb.toFile(), format)
        return "$linkPrefix$path"
    }

    override fun get(link: String, drawables: String?, type: FileService.FileType): InputStream {
        return FileInputStream(getFile(link, drawables, type))
    }

    override fun getPath(link: String, drawables: String?, type: FileService.FileType): String {
        return getFile(link, drawables, type).absolutePath
    }

    override fun delete(link: String) {
        val path = link.replace(linkPrefix, "")
        Files.delete(Paths.get(configuration.files.root, path))
        Files.delete(Paths.get(configuration.files.root, getImagePath(path, null, FileService.FileType.WITH_RECT)))
        Files.delete(Paths.get(configuration.files.root, getImagePath(path, null, FileService.FileType.WITH_RECT_THUMB)))
    }

    fun getAbsolutePath(path: String, format: String, type: FileService.FileType): Path {
        val newPath = when (type) {
            FileService.FileType.NORMAL -> path
            FileService.FileType.WITH_RECT -> getImagePath(path, format, FileService.FileType.WITH_RECT)
            FileService.FileType.WITH_RECT_THUMB -> getImagePath(path, format, FileService.FileType.WITH_RECT_THUMB)
        }
        return Paths.get(configuration.files.root.replace("///", ""), newPath)
    }

    fun getImagePath(link: String, format: String?, type: FileService.FileType): String {
        val suffix = when (type) {
            FileService.FileType.NORMAL -> ""
            FileService.FileType.WITH_RECT -> "_rect"
            FileService.FileType.WITH_RECT_THUMB -> "_rect_thumb"
        }
        return if (format != null) {
            link.replace(".$format", "$suffix.$format")
        } else {
            link.replace(".jpeg", "$suffix.jpeg")
                    .replace(".jpg", "$suffix.jpg")
                    .replace(".png", "$suffix.png")
        }
    }

    fun getRect(drawables: String?): Rect? {
        try {
            val coords = drawables
                    ?.replace("Rect(", "")
                    ?.replace(")", "")
                    ?.split(',')
            if (coords != null && coords.size == 4) {
                return Rect(coords[0].toDouble(), coords[1].toDouble(), coords[2].toDouble(), coords[3].toDouble())
            }
        } catch (e: Exception) {
            logger.error("Invalid image rect data", e)
        }
        return null
    }

    fun generateRectImages(bytes: ByteArray, rect: Rect?, file: File, thumbFile: File, format: String) {
        try {
            bytes.saveWithRect(rect, file, thumbFile, format)
            logger.info("Saved image with rect ${file.absolutePath}")
            logger.info("Saved thumb image with rect ${thumbFile.absolutePath}")
        } catch (e: Exception) {
            logger.error("Invalid image data ${file.absoluteFile}", e)
        }
    }

    fun getFile(link: String, drawables: String?, type: FileService.FileType): File {
        val path = link.replace(linkPrefix, "")
        val clearPath = File(configuration.files.root, path)
        val rectPath = File(configuration.files.root, getImagePath(path, null, FileService.FileType.WITH_RECT))
        val rectThumbPath = File(configuration.files.root, getImagePath(path, null, FileService.FileType.WITH_RECT_THUMB))
        if (clearPath.exists() && (!rectPath.exists() || !rectThumbPath.exists())) {
            generateRectImages(clearPath.readBytes(), getRect(drawables), rectPath, rectThumbPath, "jpg")
        }
        return when (type) {
            FileService.FileType.NORMAL -> clearPath
            FileService.FileType.WITH_RECT -> rectPath
            FileService.FileType.WITH_RECT_THUMB -> rectThumbPath
        }
    }
}