package com.uav_recon.app.api.repositories

import com.uav_recon.app.api.entities.db.StructureComponent
import org.springframework.data.repository.CrudRepository

interface StructureComponentRepository : CrudRepository<StructureComponent, Int>
