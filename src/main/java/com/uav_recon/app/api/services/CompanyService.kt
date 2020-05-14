package com.uav_recon.app.api.services

import com.uav_recon.app.api.repositories.CompanyRepository
import org.springframework.stereotype.Service

@Service
class CompanyService(private val companyRepository: CompanyRepository) {
}