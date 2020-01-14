package com.uav_recon.app.api.services.report.document.models

import com.uav_recon.app.api.services.report.document.models.body.Alignment
import com.uav_recon.app.api.services.report.document.models.body.BodyElement
import com.uav_recon.app.api.services.report.document.models.body.Paragraph
import com.uav_recon.app.api.services.report.document.models.body.Table

interface Page {

    companion object {
        inline fun create(lambda: Builder.() -> Unit) = Builder().apply(lambda).build()
    }

    val elements: List<BodyElement>
    val orientation: Orientation

    data class Simple(override val elements: List<BodyElement>, override val orientation: Orientation) : Page

    class Builder() {

        val list = mutableListOf<BodyElement>()
        var orientation = Orientation.PORTRAIT

        inline fun table(init: Table.Builder.()-> Unit) {
            list.add(Table.create(init))
        }

        inline fun paragraph(init: Paragraph.Builder.()-> Unit) {
            list.add(Paragraph.create(init))
        }

        inline fun paragraphLeft(init: Paragraph.Builder.() -> Unit) {
            list.add(Paragraph.create {
                init()
                alignment { Alignment.START }
            })
        }

        fun build(): Page = Simple(list, orientation)

    }

    enum class Orientation {
        PORTRAIT, LANDSCAPE
    }

}