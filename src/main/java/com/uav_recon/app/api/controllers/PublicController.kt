package com.uav_recon.app.api.controllers

import com.google.api.client.util.IOUtils
import com.uav_recon.app.configurations.UavConfiguration
import org.springframework.http.MediaType
import org.springframework.stereotype.Controller
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.RequestMapping
import java.io.File
import java.io.FileInputStream
import java.io.IOException
import javax.servlet.http.HttpServletResponse
import javax.servlet.http.HttpSession

@Controller
@RequestMapping("datarecon-public")
class PublicController(private val configuration: UavConfiguration) {

    @GetMapping("/company/image/{imageName}")
    @Throws(IOException::class)
    fun getCompanyImageAsByteArray(@PathVariable imageName: String, response: HttpServletResponse, session: HttpSession) {
        response.contentType = MediaType.IMAGE_JPEG_VALUE
        val file = FileInputStream(File(configuration.files.uploadDir, imageName.split("/").last()))
        IOUtils.copy(file, response.outputStream)
    }
}