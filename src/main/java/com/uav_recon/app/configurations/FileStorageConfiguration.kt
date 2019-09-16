package com.uav_recon.app.configurations

import org.springframework.boot.context.properties.ConfigurationProperties
import org.springframework.context.annotation.Configuration

@Configuration
@ConfigurationProperties(prefix = "file", ignoreUnknownFields = false)
class FileStorageConfiguration {
    lateinit var uploadDir: String
}