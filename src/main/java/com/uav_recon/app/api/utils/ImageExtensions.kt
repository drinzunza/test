package com.uav_recon.app.api.utils

import com.uav_recon.app.api.entities.db.Rect
import com.uav_recon.app.api.services.Error
import net.coobird.thumbnailator.Thumbnails
import java.awt.*
import java.awt.image.BufferedImage
import java.io.File
import kotlin.math.abs
import kotlin.math.ceil
import kotlin.math.roundToInt

@Throws(Error::class)
fun ByteArray.saveWithRect(rect: Rect?, file: File, thumbFile: File, format: String, size: Int = 500) {
    val needFormat = if (format.toLowerCase() == "png") "png" else "jpg"
    val inputStream = inputStream()
    val image = Thumbnails.of(inputStream).scale(1.0).asBufferedImage()
    image.drawRect(rect)
    Thumbnails.of(image)
            .scale(1.0)
            .toFile(file)
    Thumbnails.of(image)
            .scale(size.toDouble() / (if (image.width > image.height) image.width else image.height))
            .toFile(thumbFile)
    inputStream.close()
}

fun BufferedImage.drawRect(rect: Rect?) {
    rect?.let {
        val g = graphics as Graphics2D
        g.stroke = BasicStroke(8.0f)
        g.color = Color.GREEN
        g.drawRect(
                (width * rect.startX).toInt(),
                (height * rect.startY).toInt(),
                (width * abs(rect.endX - rect.startX)).toInt(),
                (height * abs(rect.endY - rect.startY)).toInt())
        g.dispose()
    }
}

fun BufferedImage.resize(targetSize: Int): BufferedImage {
    if (targetSize <= 0) {
        return this // this can't be resized
    }
    var targetWidth = targetSize
    var targetHeight = targetSize
    val ratio = height.toFloat() / width.toFloat()
    if (ratio <= 1) { //square or landscape-oriented image
        targetHeight = ceil(targetWidth.toFloat() * ratio.toDouble()).toInt()
    } else { //portrait image
        targetWidth = (targetHeight.toFloat() / ratio).roundToInt()
    }
    val bi = BufferedImage(targetWidth, targetHeight,
            if (transparency == Transparency.OPAQUE) BufferedImage.TYPE_INT_RGB else BufferedImage.TYPE_INT_ARGB
    )
    val g2d = bi.createGraphics()
    //produces a balanced resizing (fast and decent quality)
    g2d.setRenderingHint(RenderingHints.KEY_INTERPOLATION, RenderingHints.VALUE_INTERPOLATION_BILINEAR)
    g2d.drawImage(this, 0, 0, targetWidth, targetHeight, null)
    g2d.dispose()
    return bi
}
