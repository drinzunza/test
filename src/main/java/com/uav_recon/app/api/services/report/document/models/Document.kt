package com.uav_recon.app.api.services.report.document.models

interface Document {

    companion object {
        inline fun create(lambda: Builder.() -> Unit) = Builder().apply(lambda).build()
    }

    val border: Border?
    val pages: List<Page>
    val pageWidth: Int
    val pageHeight: Int

    data class Simple(
            override val border: Border?,
            override val pages: List<Page>,
            override val pageWidth: Int,
            override val pageHeight: Int
    ) : Document

    interface Border {

        val size: Int
        val space: Int
        val color: String? // ColorRes

        data class Simple(
            override val size: Int,
            override val space: Int,
            override val color: String? // ColorRes
        ) : Border

    }

    class Builder {

        var border: Border? = null
        val list = mutableListOf<Page>()
        var pageWidth: Int = (8.5 * 1440).toInt()
        var pageHeight: Int = 11 * 1440

        inline fun border(init: () -> Border) {
            border = init()
        }

        inline fun page(init: Page.Builder.() -> Unit) {
            list.add(Page.create(init))
        }

        fun build(): Document = Simple(border, list, pageWidth, pageHeight)

    }

}