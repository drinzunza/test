package com.uav_recon.app.api.repositories

import com.uav_recon.app.api.entities.db.ObservationDefect
import org.springframework.data.repository.CrudRepository

interface ObservationDefectRepository : CrudRepository<ObservationDefect, Int>