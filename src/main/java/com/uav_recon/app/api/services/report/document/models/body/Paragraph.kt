package com.uav_recon.app.api.services.report.document.models.body

import com.uav_recon.app.api.services.report.document.models.elements.Element
import com.uav_recon.app.api.services.report.document.models.elements.LineFeedElement
import com.uav_recon.app.api.services.report.document.models.elements.PictureElement
import com.uav_recon.app.api.services.report.document.models.elements.TextElement
import java.io.InputStream

interface Paragraph : BodyElement {

    companion object {

        inline fun create(lambda: Builder.() -> Unit) = Builder().apply(lambda).build()

    }

    val alignment: Alignment?

    enum class Alignment {
        LEFT,
        CENTER,
        RIGHT,
        BOTH
    }

    data class Simple(
            override val alignment: Alignment?,
            override val list: List<Element>
    ) : Paragraph

    class Builder {

        var alignment: Alignment = Alignment.CENTER
        val list = mutableListOf<Element>()

        inline fun alignment(init: () -> Alignment) {
            alignment = init()
        }

        inline fun element(init: () -> Element) {
            list.add(init())
        }

        inline fun elements(init: () -> List<Element>) {
            list.addAll(init())
        }

        inline fun text(init: () -> TextElement) {
            list.add(init())
        }

        fun text(text: String?, textSize: Int? = null, textColor: String? = null, styles: List<TextElement.Typeface> = emptyList()) {
            list.add(TextElement.Simple(text, textSize, textColor, styles))
        }

        inline fun lineFeed(init: () -> LineFeedElement) {
            list.add(init())
        }

        fun picture(name: String? = null, inputStream: InputStream, width: Int, height: Int) {
            list.add(PictureElement.Simple(name, inputStream, width, height))
        }

        fun build(): Paragraph = Simple(alignment, list)

    }

}