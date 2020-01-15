package com.uav_recon.app.api.services.report.document.models.elements

interface IconLinkElement : Element {
    val link: String
    val name: String
    val size: Double

    data class Simple(
        override val link: String,
        override val name: String,
        override val size: Double
    ) : IconLinkElement
}