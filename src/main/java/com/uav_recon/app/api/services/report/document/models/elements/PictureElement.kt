package com.uav_recon.app.api.services.report.document.models.elements

import java.io.InputStream

interface PictureElement : Element {

    val name: String?
    val inputStream: InputStream
    val width: Int
    val height: Int

    data class Simple(
        override val name: String? = null,
        override val inputStream: InputStream,
        override val width: Int,
        override val height: Int
    ) : PictureElement

}