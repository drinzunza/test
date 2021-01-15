package com.uav_recon.app.api.schedulers

import com.uav_recon.app.api.repositories.PhotoRepository
import com.uav_recon.app.api.services.FileService
import org.slf4j.LoggerFactory
import org.springframework.scheduling.annotation.Scheduled
import org.springframework.stereotype.Component
import java.util.*

@Component
class ImageScheduler(
        private val photoRepository: PhotoRepository,
        private val fileService: FileService
) {
    private val logger = LoggerFactory.getLogger(ImageScheduler::class.java)

//    @Scheduled(initialDelay = 20000, fixedRate = 86400000)
//    fun runGenerateThumbnails() {
//        val timestamp = Date().time
//        logger.info("scheduler started: runGenerateThumbnails")
//        photoRepository.findAll().forEach { photo ->
//            fileService.getPath(photo.link, photo.drawables, FileService.FileType.WITH_RECT_THUMB)
//        }
//        logger.info("scheduler stopped: runGenerateThumbnails ({} ms)", Date().time - timestamp)
//    }

    @Scheduled(initialDelay = 10000, fixedRate = 86400000)
    fun runRegenerateIncorrectThumbnails() {
        val timestamp = Date().time
        logger.info("scheduler started: runRegenerateIncorrectThumbnails")
        photoRepository.findAll().forEach { photo ->
            val rect = fileService.getRect(photo.drawables)
            if (rect != null && (rect.startX > rect.endX || rect.startY > rect.endY)) {
                logger.info("regenerate ${photo.uuid}")
                fileService.regenerateRectImages(photo)
            }
        }
        logger.info("scheduler stopped: runRegenerateIncorrectThumbnails ({} ms)", Date().time - timestamp)
    }
}