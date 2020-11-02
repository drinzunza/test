package com.uav_recon.app.api.repositories.templates

import com.uav_recon.app.api.entities.db.templates.TemplateSubcomponent
import org.springframework.data.repository.CrudRepository

interface TemplateSubcomponentRepository : CrudRepository<TemplateSubcomponent, Long>