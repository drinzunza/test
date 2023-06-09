package com.uav_recon.app.api.beans.resources

import com.fasterxml.jackson.databind.ObjectMapper
import org.springframework.stereotype.Component
import org.springframework.util.ResourceUtils

@Component
class Resources(private val objectMapper: ObjectMapper) {
    private val root = "classpath:files"

    val template by lazy {
        ResourceUtils.getURL("$root/template.docx").readBytes()
    }

    val mockImageName: String = "map.png"

    val mockImagePath: String by lazy {
        ResourceUtils.getURL("$root/map.png").path
    }

    fun getData(name: String): ByteArray? {
        return ResourceUtils.getURL("$root/$name").readBytes()
    }
}