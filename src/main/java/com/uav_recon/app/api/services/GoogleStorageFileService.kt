package com.uav_recon.app.api.services

import com.google.auth.ServiceAccountSigner
import com.google.cloud.storage.BlobId
import com.google.cloud.storage.BlobInfo
import com.google.cloud.storage.Storage
import com.google.cloud.storage.StorageOptions
import com.uav_recon.app.api.entities.db.Photo
import com.uav_recon.app.api.entities.db.Rect
import com.uav_recon.app.api.utils.drawRect
import com.uav_recon.app.api.utils.saveThumbToMemory
import com.uav_recon.app.configurations.UavConfiguration
import net.coobird.thumbnailator.Thumbnails
import org.slf4j.LoggerFactory
import java.io.ByteArrayOutputStream
import java.io.DataOutputStream
import java.io.InputStream
import java.io.OutputStream
import java.lang.Exception
import java.util.concurrent.TimeUnit

class GoogleStorageFileService(private val configuration: UavConfiguration) : FileService {
    private val logger = LoggerFactory.getLogger(GoogleStorageFileService::class.java)
    private val storage = StorageOptions.getDefaultInstance().service
    private val linkPrefix = "https://storage.cloud.google.com/"
    private val bucketDirectory = "${configuration.files.gsBucket}/data/"

    override fun save(path: String, bytes: ByteArray, format: String, drawables: String?): String {
        storage.create(BlobInfo.newBuilder(configuration.files.gsBucket, "data/$path").build(), bytes)
        return "$linkPrefix$bucketDirectory$path"
    }

    override fun saveAnnotatedPhoto(path: String, bytes: ByteArray, format: String): String {
        val pathWithRect = getImagePath(path, format, FileService.FileType.WITH_RECT)
        val pathWithRectThumb = getImagePath(path, format, FileService.FileType.WITH_RECT_THUMB)

        val thumbImageBytes = generateThumbImageForFile(bytes, format)

        storage.create(BlobInfo.newBuilder(configuration.files.gsBucket, "data/$pathWithRect").build(), bytes)
        storage.create(BlobInfo.newBuilder(configuration.files.gsBucket, "data/$pathWithRectThumb").build(), thumbImageBytes)
        return "$linkPrefix$bucketDirectory$path"
    }

    override fun delete(link: String) {
        storage.delete(BlobId.of(configuration.files.gsBucket, link.replace("$linkPrefix${configuration.files.gsBucket}/", "")))
    }

    override fun getLink(path: String): String {
        return "$linkPrefix${configuration.files.gsBucket}/$path"
    }

    override fun get(link: String, drawables: String?, type: FileService.FileType): InputStream {
        var blobName = link
        val split = link.split('.')
        val name = split.getOrNull(split.size - 2)

        if (type == FileService.FileType.WITH_RECT) {
            blobName = name?.let { blobName.replace(name, "${name}_rect") } ?: blobName
        } else if (type == FileService.FileType.WITH_RECT_THUMB) {
            blobName = name?.let { blobName.replace(name, "${name}_rect_thumb") } ?: blobName
        }

        blobName = blobName.replace("$linkPrefix${configuration.files.gsBucket}/", "")

        return storage.get(BlobId.of(configuration.files.gsBucket, blobName))
                .getContent()
                .inputStream()
    }

    override fun getPath(link: String, drawables: String?, type: FileService.FileType): String {
        return ""
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

    override fun regenerateRectImages(photo: Photo) {
        try {
            val path = photo.link.substringAfter("$linkPrefix$bucketDirectory")
            val format = path.split(".").last()
            val clearInputStream = get(photo.link, photo.drawables, FileService.FileType.NORMAL)
            val image = Thumbnails.of(clearInputStream).scale(1.0).asBufferedImage()
            val outputStream = ByteArrayOutputStream()
            image.drawRect(getRect(photo.drawables))
            Thumbnails.of(image)
                .scale(1.0)
                .outputFormat(format)
                .toOutputStream(outputStream)
            saveAnnotatedPhoto(path, outputStream.toByteArray(), format)
            clearInputStream.close()
            outputStream.close()
        } catch (e: Exception) {
            logger.error("regenerateRectImages failed", e)
        }
    }

    override fun generateSignedLink(link: String): String {
        val blobInfo = BlobInfo.newBuilder(
            BlobId.of(
                configuration.files.gsBucket,
                link.replace("$linkPrefix${configuration.files.gsBucket}/", "")
            )
        ).build()

        return storage.signUrl(
            blobInfo,
            1,
            TimeUnit.DAYS,
            Storage.SignUrlOption.withV4Signature(),
            Storage.SignUrlOption.signWith(storage.options.credentials as ServiceAccountSigner)
        ).toString()
    }

    private fun generateThumbImageForFile(bytes: ByteArray, format: String): ByteArray? {
        try {
            if (format == "docx") return null
            return bytes.saveThumbToMemory(format)
        } catch (e: Exception) {
            logger.error("Invalid image data", e)
        }

        return null
    }
}
