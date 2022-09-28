package com.uav_recon.app.api.services

import com.uav_recon.app.api.entities.db.Photo
import com.uav_recon.app.api.entities.db.Rect
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

    override fun saveAnnotatedPhoto(path: String, bytes: ByteArray, format: String): String {
        return service.saveAnnotatedPhoto(path, bytes, format)
    }

    override fun delete(link: String) {
        service.delete(link)
    }

    override fun getLink(path: String): String {
        return service.getLink(path)
    }

    override fun get(link: String, drawables: String?, type: FileService.FileType): InputStream {
        return service.get(link, drawables, type)
    }

    override fun getPath(link: String, drawables: String?, type: FileService.FileType): String {
        return service.getPath(link, drawables, type)
    }

    override fun getImagePath(link: String, format: String?, type: FileService.FileType): String {
        return service.getImagePath(link, format, type)
    }

    override fun getRect(drawables: String?): Rect? {
        return service.getRect(drawables)
    }

    override fun regenerateRectImages(photo: Photo) {
        service.regenerateRectImages(photo)
    }
}
