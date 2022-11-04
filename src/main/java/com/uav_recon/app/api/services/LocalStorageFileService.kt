package com.uav_recon.app.api.services

import com.uav_recon.app.api.entities.db.Photo
import com.uav_recon.app.api.entities.db.Rect
import com.uav_recon.app.api.utils.saveThumb
import com.uav_recon.app.api.utils.saveWithRect
import com.uav_recon.app.configurations.UavConfiguration
import org.apache.commons.lang3.StringUtils
import org.slf4j.LoggerFactory
import java.io.ByteArrayInputStream
import java.io.File
import java.io.FileInputStream
import java.io.InputStream
import java.io.FileNotFoundException
import java.nio.file.*

class LocalStorageFileService(private val configuration: UavConfiguration) : FileService {
    private val logger = LoggerFactory.getLogger(LocalStorageFileService::class.java)
    private val serverId = if (!StringUtils.isBlank(configuration.server.id)) "/${configuration.server.id}" else ""
    private val linkPrefix = "${configuration.server.host}$serverId/files/"

    override fun save(path: String, bytes: ByteArray, format: String, drawables: String?): String {
        val absolutePath = getAbsolutePath(path, format, FileService.FileType.NORMAL)
//        val absolutePathWithRect = getAbsolutePath(path, format, FileService.FileType.WITH_RECT)
//        val absolutePathWithRectThumb = getAbsolutePath(path, format, FileService.FileType.WITH_RECT_THUMB)

        val parentFile = absolutePath.toFile().parentFile
        if (!parentFile.exists()) {
            Files.createDirectories(parentFile.toPath())
        }
        if (absolutePath.toFile().exists()) {
            Files.copy(ByteArrayInputStream(bytes), absolutePath, StandardCopyOption.REPLACE_EXISTING)
        } else {
            Files.write(absolutePath, bytes, StandardOpenOption.CREATE_NEW)
        }
        logger.info("File $absolutePath (${absolutePath.toFile().exists()})")

//        generateRectImages(bytes, getRect(drawables), absolutePathWithRect.toFile(), absolutePathWithRectThumb.toFile(), format)
        return "$linkPrefix$path"
    }

    override fun saveAnnotatedPhoto(path: String, bytes: ByteArray, format: String): String {
        val absolutePathWithRect = getAbsolutePath(path, format, FileService.FileType.WITH_RECT)
        val absolutePathWithRectThumb = getAbsolutePath(path, format, FileService.FileType.WITH_RECT_THUMB)

        val parentFile = absolutePathWithRect.toFile().parentFile
        if (!parentFile.exists()) {
            Files.createDirectories(parentFile.toPath())
        }
        if (absolutePathWithRect.toFile().exists()) {
            Files.copy(ByteArrayInputStream(bytes), absolutePathWithRect, StandardCopyOption.REPLACE_EXISTING)
        } else {
            Files.write(absolutePathWithRect, bytes, StandardOpenOption.CREATE_NEW)
        }

        generateThumbImageForFile(bytes, absolutePathWithRect.toFile(), absolutePathWithRectThumb.toFile(), format)
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

    override fun getLink(path: String): String {
        val absolutePath = getAbsolutePath(path, "", FileService.FileType.NORMAL)
        if (absolutePath.toFile().exists()) {
            return "$linkPrefix$path"
        } else {
            throw FileNotFoundException()
        }
    }

    override fun regenerateRectImages(photo: Photo) {
        return
        val path = photo.link.replace(linkPrefix, "")
        val clearPath = File(configuration.files.root, path)
        val rectPath = File(configuration.files.root, getImagePath(path, null, FileService.FileType.WITH_RECT))
        val rectThumbPath = File(configuration.files.root, getImagePath(path, null, FileService.FileType.WITH_RECT_THUMB))
        if (clearPath.exists()) {
            val format = if (path.endsWith(".png", true)) "png" else "jpg"
            generateRectImages(clearPath.readBytes(), getRect(photo.drawables), rectPath, rectThumbPath, format)
        }
    }

    fun getAbsolutePath(path: String, format: String, type: FileService.FileType): Path {
        val newPath = when (type) {
            FileService.FileType.NORMAL -> path
            FileService.FileType.WITH_RECT -> getImagePath(path, format, FileService.FileType.WITH_RECT)
            FileService.FileType.WITH_RECT_THUMB -> getImagePath(path, format, FileService.FileType.WITH_RECT_THUMB)
        }
        return Paths.get(configuration.files.root.replace("///", ""), newPath)
    }

    override fun getImagePath(link: String, format: String?, type: FileService.FileType): String {
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

    override fun getRect(drawables: String?): Rect? {
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

    override fun generateSignedLink(link: String): String {
        return getLink(link)
    }

    fun generateRectImages(bytes: ByteArray, rect: Rect?, file: File, thumbFile: File, format: String) {
        try {
            if (format == "docx") return
            bytes.saveWithRect(rect, file, thumbFile, format)
            logger.info("Saved image with rect ${file.absolutePath}")
            logger.info("Saved thumb image with rect ${thumbFile.absolutePath}")
        } catch (e: Exception) {
            logger.error("Invalid image data ${file.absoluteFile}", e)
        }
    }

    fun generateThumbImageForFile(bytes: ByteArray, file: File, thumbFile: File, format: String) {
        try {
            if (format == "docx") return
            bytes.saveThumb(file, thumbFile, format)
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
            val format = if (path.endsWith(".png", true)) "png" else "jpg"
            generateRectImages(clearPath.readBytes(), getRect(drawables), rectPath, rectThumbPath, format)
        }
        return when (type) {
            FileService.FileType.NORMAL -> clearPath
            FileService.FileType.WITH_RECT -> rectPath
            FileService.FileType.WITH_RECT_THUMB -> rectThumbPath
        }
    }
}