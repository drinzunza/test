package com.uav_recon.app.api.repositories

import com.uav_recon.app.api.entities.db.StructuralComponent
import org.springframework.data.repository.CrudRepository

interface StructuralComponentRepository : CrudRepository<StructuralComponent, Int>