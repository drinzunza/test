package com.uav_recon.app.api.utils

import com.uav_recon.app.api.entities.db.Rect
import com.uav_recon.app.api.services.Error
import java.awt.BasicStroke
import java.awt.Color
import java.awt.Graphics2D
import java.awt.Image
import java.awt.image.BufferedImage
import java.io.File
import javax.imageio.ImageIO
import kotlin.math.abs

@Synchronized
@Throws(Error::class)
fun ByteArray.saveWithRect(rect: Rect?, file: File, smallFile: File, format: String) {
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
        val resized = image.resize(500, 500)
        ImageIO.write(resized, needFormat, smallFile)
        inputStream.close()
    }
}

fun BufferedImage.resize(height: Int, width: Int): BufferedImage {
    val tmp = getScaledInstance(width, height, Image.SCALE_SMOOTH)
    val resized = BufferedImage(width, height, BufferedImage.TYPE_INT_ARGB)
    val g2d = resized.createGraphics()
    g2d.drawImage(tmp, 0, 0, null)
    g2d.dispose()
    return resized
}
