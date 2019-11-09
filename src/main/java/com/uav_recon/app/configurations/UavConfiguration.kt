package com.uav_recon.app.configurations

import org.springframework.boot.context.properties.ConfigurationProperties
import org.springframework.context.annotation.Configuration
import org.springframework.validation.annotation.Validated
import javax.validation.constraints.NotBlank
import javax.validation.constraints.Pattern

@Configuration
@ConfigurationProperties(prefix = "uav", ignoreUnknownFields = false)
@Validated
class UavConfiguration {
    val security = Security()
    val token = Token()
    val files = Files()

    class Security {
        @Pattern(regexp = "\\d{1,2}", message = "Must be in range of 1-99 minutes")
        lateinit var resetPasswordTimeout: String
        @Pattern(regexp = "[6-9]", message = "Must be in range of 6-9")
        lateinit var resetPasswordCodeLength: String
    }

    class Token {
        @NotBlank
        lateinit var secret: String
        @Pattern(regexp = "\\d{4,6}", message = "Must be between in range of 1000-999999 seconds")
        lateinit var tokenExpirationTime: String
    }

    class Files {
        @NotBlank
        lateinit var uploadDir: String
    }
}
