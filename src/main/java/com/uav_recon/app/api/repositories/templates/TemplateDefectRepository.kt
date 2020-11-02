package com.uav_recon.app.api.repositories.templates

import com.uav_recon.app.api.entities.db.templates.TemplateDefect
import org.springframework.data.repository.CrudRepository

interface TemplateDefectRepository : CrudRepository<TemplateDefect, Long>