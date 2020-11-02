package com.uav_recon.app.api.repositories.templates

import com.uav_recon.app.api.entities.db.templates.TemplateComponent
import org.springframework.data.repository.CrudRepository

interface TemplateComponentRepository : CrudRepository<TemplateComponent, Long>