package com.uav_recon.app.api.services.report.document.models.elements

interface LinkTextElement : TextElement {

    data class Simple(
        override val text: String?,
        override val textSize: Int? = null,
        override val textColor: String? = "#0000FF",
        override val styles: List<TextElement.Typeface> = listOf(TextElement.Typeface.UNDERLINE)
    ) : LinkTextElement
}