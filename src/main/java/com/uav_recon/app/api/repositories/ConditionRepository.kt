package com.uav_recon.app.api.repositories

import com.uav_recon.app.api.entities.db.Condition
import org.springframework.data.repository.CrudRepository

interface ConditionRepository : CrudRepository<Condition, Int>