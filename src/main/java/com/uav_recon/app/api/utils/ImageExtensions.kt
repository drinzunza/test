package com.uav_recon.app.api.utils

import com.uav_recon.app.api.entities.db.Rect
import com.uav_recon.app.api.services.Error
import java.awt.*
import java.awt.image.BufferedImage
import java.io.File
import javax.imageio.ImageIO
import kotlin.math.abs
import kotlin.math.ceil
import kotlin.math.roundToInt

@Synchronized
@Throws(Error::class)
fun ByteArray.saveWithRect(rect: Rect?, file: File, smallFile: File, format: String, size: Int = 500) {
    val needFormat = if (format.toLowerCase() == "png") "png" else "jpg"
    if (rect != null) {
        val inputStream = inputStream()
        val image = ImageIO.read(inputStream)

        val g = image.graphics as Graphics2D
        g.stroke = BasicStroke(8.0f)
        g.color = Color.GREEN
        g.drawRect(
                (image.width * rect.startX).toInt(),
                (image.height * rect.startY).toInt(),
                (image.width * abs(rect.endX - rect.startX)).toInt(),
                (image.height * abs(rect.endY - rect.startY)).toInt())
        g.dispose()
        ImageIO.write(image, needFormat, file)
        val resized = image.resize(size) //image.resize(resizedWidth, resizedHeight)
        ImageIO.write(resized, needFormat, smallFile)
        inputStream.close()
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
