package com.uav_recon.app.api.services.report.document.models.elements

interface TextElement : Element {

    val text: String?
    val textSize: Int?
    val textColor: String? // Color Res

    val styles: List<Typeface>

    enum class Typeface {
        BOLD,
        ITALIC,
        UNDERLINE,
        STRIKE
    }

    data class Simple(
        override val text: String?,
        override val textSize: Int? = null,
        override val textColor: String? = null,
        override val styles: List<Typeface> = emptyList()
    ) : TextElement
}