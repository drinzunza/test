package com.uav_recon.app.api.entities.responses

class UploadFileResponse(
        val fileName: String,
        val fileDownloadUri: String,
        val fileType: String,
        val size: Long
)