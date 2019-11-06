package com.uav_recon.app.api.repositories

import com.uav_recon.app.api.entities.db.User
import org.springframework.data.jpa.repository.JpaRepository
import java.util.*

interface UserRepository : JpaRepository<User, Long> {
    fun findFirstByEmail(email: String): Optional<User>
}
