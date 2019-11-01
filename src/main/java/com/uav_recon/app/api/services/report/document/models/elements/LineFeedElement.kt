package com.uav_recon.app.api.services.report.document.models.elements

interface LineFeedElement : Element {

    val count: Int

    data class Simple(
        override var count: Int = 1
    ) : LineFeedElement

}