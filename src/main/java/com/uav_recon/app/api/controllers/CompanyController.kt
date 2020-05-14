package com.uav_recon.app.api.controllers

import com.uav_recon.app.api.entities.db.CompanyType
import com.uav_recon.app.api.entities.requests.bridge.CompanyDto
import com.uav_recon.app.api.services.CompanyService
import com.uav_recon.app.configurations.ControllerConfiguration.VERSION
import com.uav_recon.app.configurations.ControllerConfiguration.X_TOKEN
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*

@RestController
@RequestMapping("${VERSION}/companies")
class CompanyController(private val companyService: CompanyService) : BaseController() {

    @GetMapping
    fun getCompanies(@RequestHeader(X_TOKEN) token: String, @RequestParam(required = false) type: CompanyType?): ResponseEntity<List<CompanyDto>> {
        return ResponseEntity.ok(companyService.listNotDeleted(getAuthenticatedUser(), type))
    }

    @GetMapping("/{id}")
    fun getCompany(@RequestHeader(X_TOKEN) token: String, @PathVariable id: Long): ResponseEntity<CompanyDto> {
        return ResponseEntity.ok(companyService.getNotDeleted(getAuthenticatedUser(), id))
    }

    @PostMapping("/save")
    fun saveCompany(@RequestHeader(X_TOKEN) token: String, @RequestBody body: CompanyDto): ResponseEntity<CompanyDto> {
        return ResponseEntity.ok(companyService.save(getAuthenticatedUser(), body))
    }

    @DeleteMapping("/delete")
    fun deleteCompany(@RequestHeader(X_TOKEN) token: String, @RequestParam id: Long): ResponseEntity<*> {
        companyService.delete(getAuthenticatedUser(), id)
        return ResponseEntity.ok(success)
    }
}
