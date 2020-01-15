package com.uav_recon.app.api.services.report.document.models.body

import com.uav_recon.app.api.services.report.document.models.elements.Element

interface BodyElement {
    val list: List<Element>
}