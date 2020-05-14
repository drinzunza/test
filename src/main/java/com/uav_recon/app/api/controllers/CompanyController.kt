package com.uav_recon.app.api.controllers

import com.uav_recon.app.api.entities.requests.bridge.CompanyDto
import com.uav_recon.app.api.services.CompanyService
import com.uav_recon.app.configurations.ControllerConfiguration.VERSION
import com.uav_recon.app.configurations.ControllerConfiguration.X_TOKEN
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*

@RestController
@RequestMapping("${VERSION}/companies")
class CompanyController(private val companyService: CompanyService) : BaseController() {

    @PostMapping("/save")
    fun saveCompany(@RequestHeader(X_TOKEN) token: String, @RequestBody body: CompanyDto): ResponseEntity<CompanyDto> {
        return ResponseEntity.ok(companyService.save(getAuthenticatedUser(), getAuthenticatedCompanyId(), body))
    }
}
