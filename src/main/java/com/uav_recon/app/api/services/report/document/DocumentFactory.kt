package com.uav_recon.app.api.services.report.document

import com.uav_recon.app.api.entities.db.Report
import com.uav_recon.app.api.services.report.document.models.Document

interface DocumentFactory {
    fun generateDocument(report: Report, isInverse: Boolean = false) : Document
}
