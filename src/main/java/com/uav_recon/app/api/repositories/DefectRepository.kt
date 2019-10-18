package com.uav_recon.app.api.repositories

import com.uav_recon.app.api.entities.db.Defect
import org.springframework.data.repository.CrudRepository

interface DefectRepository : CrudRepository<Defect, Int>