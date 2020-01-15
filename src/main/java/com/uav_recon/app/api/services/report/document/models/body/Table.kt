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
    val merges: List<Merge>

    data class Simple(
            override val width: Int?,
            override val height: Int?,
            override val withBorders: Boolean,
            override val list: List<Row>,
            override val merges: List<Merge>
    ) : Table

    class Builder {

        var width: Int? = null
        var height: Int? = null
        var withBorders: Boolean = true
        val rows = mutableListOf<Row>()
        val merges = mutableListOf<Merge>()

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

        fun merge(
                direction: Merge.Direction,
                mainAxisIndex: Int,
                startAxisIndex: Int,
                endAxisIndex: Int
        ) {
            merges.add(Merge.Simple(direction, mainAxisIndex, startAxisIndex, endAxisIndex))
        }

        inline fun merges(init: () -> List<Merge>) {
            merges.addAll(init())
        }

        fun build(): Table = Simple(width, height, withBorders, rows, merges)

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
            val verticalAlignment: Alignment

            data class Simple(
                    override val paragraph: Paragraph?,
                    override val height: Int? = null,
                    override val width: Int? = null,
                    override val color: String? = null,
                    override val verticalAlignment: Alignment
            ) : Cell

            class Builder {

                var paragraph: Paragraph? = null
                var height: Int? = null
                var width: Int? = null
                var color: String? = null
                var verticalAlignment: Alignment = Alignment.CENTER

                inline fun paragraph(init: Paragraph.Builder.() -> Unit) {
                    paragraph = Paragraph.create(init)
                }

                inline fun paragraphLeft(init: Paragraph.Builder.() -> Unit) {
                    paragraph = Paragraph.create {
                        init()
                        alignment { Alignment.START }
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

                inline fun verticalAlignment(init: () -> Alignment) {
                    verticalAlignment = init()
                }

                fun build(): Cell = Simple(paragraph, height, width, color, verticalAlignment)

            }
        }
    }

    interface Merge {

        val direction: Direction
        val mainAxisIndex: Int
        val startAxisIndex: Int
        val endAxisIndex: Int

        data class Simple(
                override val direction: Direction,
                override val mainAxisIndex: Int,
                override val startAxisIndex: Int,
                override val endAxisIndex: Int
        ) : Merge

        enum class Direction {
            HORIZONTAL, VERTICAL
        }
    }

}