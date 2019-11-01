package com.uav_recon.app.api.services.report.document.models.body

import com.uav_recon.app.api.services.report.document.models.elements.Element

interface Table : BodyElement {

    companion object {

        inline fun create(lambda: Builder.() -> Unit) = Builder().apply(lambda).build()

    }

    val width: Int?
    val height: Int?
    val withBorders: Boolean
    override val list: List<Row>

    data class Simple(
        override val width: Int?,
        override val height: Int?,
        override val withBorders: Boolean,
        override val list: List<Row>
    ) : Table

    class Builder {

        var width: Int? = null
        var height: Int? = null
        var withBorders: Boolean = true
        val rows = mutableListOf<Row>()

        inline fun width(init: () -> Int) {
            width = init()
        }

        inline fun height(init: () -> Int) {
            height = init()
        }

        inline fun borders(init: () -> Boolean) {
            withBorders = init()
        }

        inline fun row(init: Row.Builder.() -> Unit) {
            rows.add(Row.create(init))
        }

        inline fun rows(init: () -> List<Row>) {
            rows.addAll(init())
        }

        fun build(): Table = Simple(width, height, withBorders, rows)

    }

    interface Row : Element {


        companion object {

            inline fun create(lambda: Builder.() -> Unit) = Builder().apply(lambda).build()

        }

        val cells: List<Cell>

        data class Simple(override val cells: List<Cell>) : Row

        class Builder {

            val list = mutableListOf<Cell>()

            inline fun cell(init: Cell.Builder.() -> Unit) {
                list.add(
                    Cell.Builder()
                        .apply(init)
                        .build()
                )
            }

            inline fun cells(init: () -> List<Cell>) {
                list.addAll(init())
            }

            fun build(): Row = Simple(list)

        }

        interface Cell {

            companion object {

                fun create(lambda: Builder.() -> Unit) = Builder().apply(lambda).build()

            }

            val paragraph: Paragraph?
            val height: Int?
            val width: Int?
            val color: String?

            data class Simple(
                    override val paragraph: Paragraph?,
                    override val height: Int? = null,
                    override val width: Int? = null,
                    override val color: String? = null
            ) : Cell

            class Builder {

                var paragraph: Paragraph? = null
                var height: Int? = null
                var width: Int? = null
                var color: String? = null

                inline fun paragraph(init: Paragraph.Builder.() -> Unit) {
                    paragraph = Paragraph.create(init)
                }

                inline fun paragraphLeft(init: Paragraph.Builder.() -> Unit) {
                    paragraph = Paragraph.create {
                        init()
                        alignment { Paragraph.Alignment.LEFT }
                    }
                }

                inline fun height(init: () -> Int) {
                    height = init()
                }

                inline fun width(init: () -> Int) {
                    width = init()
                }

                inline fun color(init: () -> String) {
                    color = init()
                }

                fun build(): Cell = Simple(paragraph, height, width, color)

            }

        }

    }

}