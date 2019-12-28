package com.uav_recon.app.api.services

import com.uav_recon.app.api.entities.db.Rect
import com.uav_recon.app.configurations.UavConfiguration
import org.apache.commons.lang3.StringUtils
import org.slf4j.LoggerFactory
import java.awt.BasicStroke
import java.awt.Color
import java.awt.Graphics2D
import java.awt.image.BufferedImage
import java.io.ByteArrayInputStream
import java.io.File
import java.io.FileInputStream
import java.io.InputStream
import java.nio.file.Files
import java.nio.file.Paths
import java.nio.file.StandardCopyOption
import java.nio.file.StandardOpenOption
import java.util.stream.Stream
import javax.imageio.ImageIO
import kotlin.math.abs

class LocalStorageFileService(private val configuration: UavConfiguration) : FileService {
    private val serverId = if (!StringUtils.isBlank(configuration.server.id)) "/${configuration.server.id}" else ""
    private val linkPrefix = "${configuration.server.host}$serverId/files/"

    private val logger = LoggerFactory.getLogger(LocalStorageFileService::class.java)

    override fun save(path: String, bytes: ByteArray, format: String, drawables: String?): String {
        val absolutePath = Paths.get(configuration.files.root.replace("///", ""), path)
        val absolutePathWithRect = Paths.get(configuration.files.root.replace("///", ""),
                path.replace(".$format", "_rect.$format"))
        val parentFile = absolutePath.toFile().parentFile
        if (!parentFile.exists()) {
            Files.createDirectories(parentFile.toPath())
        }
        if (absolutePath.toFile().exists()) {
            Files.copy(ByteArrayInputStream(bytes), absolutePath, StandardCopyOption.REPLACE_EXISTING)
        } else {
            Files.write(absolutePath, bytes, StandardOpenOption.CREATE_NEW)
        }
        saveWithRect(bytes, getRect(drawables), absolutePathWithRect.toFile(), format)
        return "$linkPrefix$path"
    }

    override fun get(link: String, drawables: String?, withRect: Boolean): InputStream {
        val path = link.replace(linkPrefix, "")
        val clearPath = File(configuration.files.root, path)
        val rectPath = File(configuration.files.root, getRectLink(path))
        if (withRect) {
            if (!rectPath.exists()) {
                val bytes = clearPath.readBytes()
                saveWithRect(bytes, getRect(drawables), rectPath, "jpg")
            }
        }

        return FileInputStream(if (withRect) rectPath else clearPath)

    }

    override fun delete(link: String) {
        val path = link.replace(linkPrefix, "")
        Files.delete(Paths.get(configuration.files.root, path))
        Files.delete(Paths.get(configuration.files.root, getRectLink(path)))
    }

    private fun getRectLink(link: String): String {
        return link
                .replace(".jpeg", "_rect.jpeg")
                .replace(".jpg", "_rect.jpg")
                .replace(".png", "_rect.png")
    }

    private fun getRect(drawables: String?): Rect? {
        val coords = drawables
                ?.replace("Rect(", "")
                ?.replace(")", "")
                ?.split(',')
        return if (coords != null && coords.size == 4)
            Rect(coords[0].toDouble(), coords[1].toDouble(), coords[2].toDouble(), coords[3].toDouble())
        else
            null
    }

    @Synchronized
    private fun saveWithRect(bytes: ByteArray, rect: Rect?, file: File, format: String) {
        val needFormat = if (format.toLowerCase() == "png") "png" else "jpg"
        if (rect != null) {
            val image: BufferedImage = ImageIO.read(bytes.inputStream())
            val g = image.graphics as Graphics2D
            g.stroke = BasicStroke(8.0f)
            g.color = Color.GREEN
            g.drawRect(
                    (image.width * rect.startX).toInt(),
                    (image.height * rect.startY).toInt(),
                    (image.width * abs(rect.endX - rect.startX)).toInt(),
                    (image.height * abs(rect.endY - rect.startY)).toInt())
            ImageIO.write(image, needFormat, file)
        }
        logger.info("Saved image with rect ${file.absolutePath}")
    }
}
