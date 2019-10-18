package com.uav_recon.app.api.controllers

import com.uav_recon.app.api.entities.db.Company
import com.uav_recon.app.api.entities.db.Condition
import com.uav_recon.app.api.entities.responses.Response
import com.uav_recon.app.api.repositories.CompanyRepository
import com.uav_recon.app.api.repositories.ConditionRepository
import com.uav_recon.app.api.utils.response
import com.uav_recon.app.configurations.ControllerConfiguration.VERSION
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RestController

@RestController
class DataController(
        private val companyRepository: CompanyRepository,
        private val conditionRepository: ConditionRepository) {

    @GetMapping("$VERSION/companies")
    fun companies(): Response<List<Company>> {
        return companyRepository.findAll().toMutableList().response()
    }

    @GetMapping("$VERSION/conditions")
    fun conditions(): Response<List<Condition>> {
        return conditionRepository.findAll().toMutableList().response()
    }
}