package com.uav_recon.app.api.services.report

import com.uav_recon.app.api.services.report.document.models.Document
import java.io.File

interface DocumentWriter {
    fun writeDocument(document: Document, filePath: String)

    fun writeDocumentToMemory(document: Document) : ByteArray
}