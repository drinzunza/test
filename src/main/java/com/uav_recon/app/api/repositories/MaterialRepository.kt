package com.uav_recon.app.api.repositories

import com.uav_recon.app.api.entities.db.Material
import org.springframework.data.repository.CrudRepository

interface MaterialRepository : CrudRepository<Material, Int>