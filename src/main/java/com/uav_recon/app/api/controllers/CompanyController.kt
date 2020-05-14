package com.uav_recon.app.api.controllers

import com.uav_recon.app.api.services.CompanyService
import com.uav_recon.app.configurations.ControllerConfiguration.VERSION
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping("${VERSION}/companies")
class CompanyController(private val companyService: CompanyService) {
}
