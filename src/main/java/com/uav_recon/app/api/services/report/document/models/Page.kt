package com.uav_recon.app.api.services.report.document.models

import com.uav_recon.app.api.services.report.document.models.body.BodyElement
import com.uav_recon.app.api.services.report.document.models.body.Paragraph
import com.uav_recon.app.api.services.report.document.models.body.Table

interface Page {

    companion object {

        inline fun create(lambda: Builder.() -> Unit) = Builder().apply(lambda).build()

    }

    val elements: List<BodyElement>

    data class Simple(override val elements: List<BodyElement>) : Page

    class Builder() {

        val list = mutableListOf<BodyElement>()

        inline fun table(init: Table.Builder.()-> Unit) {
            list.add(Table.create(init))
        }

        inline fun paragraph(init: Paragraph.Builder.()-> Unit) {
            list.add(Paragraph.create(init))
        }

        inline fun paragraphLeft(init: Paragraph.Builder.() -> Unit) {
            list.add(Paragraph.create {
                init()
                alignment { Paragraph.Alignment.LEFT }
            })
        }

        fun build(): Page = Simple(list)

    }

}