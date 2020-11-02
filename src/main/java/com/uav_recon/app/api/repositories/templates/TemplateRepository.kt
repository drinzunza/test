package com.uav_recon.app.api.repositories.templates

import com.uav_recon.app.api.entities.db.templates.Template
import org.springframework.data.repository.CrudRepository

interface TemplateRepository : CrudRepository<Template, Long>