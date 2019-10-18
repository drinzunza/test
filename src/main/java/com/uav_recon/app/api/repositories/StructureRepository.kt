package com.uav_recon.app.api.repositories

import com.uav_recon.app.api.entities.db.Structure
import org.springframework.data.repository.CrudRepository

interface StructureRepository : CrudRepository<Structure, Int>