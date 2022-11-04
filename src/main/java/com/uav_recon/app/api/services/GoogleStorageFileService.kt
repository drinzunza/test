package com.uav_recon.app.api.services

import com.google.cloud.storage.BlobId
import com.google.cloud.storage.BlobInfo
import com.google.cloud.storage.Storage
import com.google.cloud.storage.StorageOptions
import com.uav_recon.app.api.entities.db.Photo
import com.uav_recon.app.api.entities.db.Rect
import com.uav_recon.app.api.utils.saveThumbToMemory
import com.uav_recon.app.configurations.UavConfiguration
import org.slf4j.LoggerFactory
import java.io.InputStream
import java.lang.Exception
import java.util.concurrent.TimeUnit

class GoogleStorageFileService(private val configuration: UavConfiguration) : FileService {
    private val logger = LoggerFactory.getLogger(GoogleStorageFileService::class.java)
    private val storage = StorageOptions.getDefaultInstance().service
    private val linkPrefix = "https://storage.cloud.google.com/"

    override fun save(path: String, bytes: ByteArray, format: String, drawables: String?): String {
        storage.create(BlobInfo.newBuilder(configuration.files.gsBucket, path).build(), bytes)
        return "$linkPrefix${configuration.files.gsBucket}/$path"
    }

    override fun saveAnnotatedPhoto(path: String, bytes: ByteArray, format: String): String {
        val pathWithRect = getImagePath(path, format, FileService.FileType.WITH_RECT)
        val pathWithRectThumb = getImagePath(path, format, FileService.FileType.WITH_RECT_THUMB)

        val thumbImageBytes = generateThumbImageForFile(bytes, format)

        storage.create(BlobInfo.newBuilder(configuration.files.gsBucket, pathWithRect).build(), bytes)
        storage.create(BlobInfo.newBuilder(configuration.files.gsBucket, pathWithRectThumb).build(), thumbImageBytes)
        return "$linkPrefix${configuration.files.gsBucket}/$path"
    }

    override fun delete(link: String) {
        storage.delete(BlobId.of(configuration.files.gsBucket, link.replace("$linkPrefix${configuration.files.gsBucket}/", "")))
    }

    override fun getLink(path: String): String {
        return "$linkPrefix${configuration.files.gsBucket}/$path"
    }

    override fun get(link: String, drawables: String?, type: FileService.FileType): InputStream {
        return storage.get(BlobId.of(configuration.files.gsBucket, link.replace("$linkPrefix${configuration.files.gsBucket}/", "")))
                .getContent()
                .inputStream()
    }

    override fun getPath(link: String, drawables: String?, type: FileService.FileType): String {
        // TODO fix
        return ""
        //return storage.get(BlobId.of(configuration.files.gsBucket, link.replace(linkPrefix, "")))
        //        .getContent()
        //        .inputStream()
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
        return null
    }

    override fun regenerateRectImages(photo: Photo) {
        TODO("Not yet implemented")
    }

    override fun generateSignedLink(link: String): String {
        val blobInfo = BlobInfo.newBuilder(
            BlobId.of(
                configuration.files.gsBucket,
                link.replace("$linkPrefix${configuration.files.gsBucket}/", "")
            )
        ).build()

        return storage.signUrl(blobInfo, 60, TimeUnit.MINUTES, Storage.SignUrlOption.withV4Signature()).toString()
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
