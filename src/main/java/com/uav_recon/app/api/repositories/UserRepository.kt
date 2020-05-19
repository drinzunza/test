package com.uav_recon.app.api.repositories

import com.uav_recon.app.api.entities.db.User
import org.springframework.data.jpa.repository.JpaRepository
import java.util.*

interface UserRepository : JpaRepository<User, Long> {
    fun findFirstById(userId: Long): User?
    fun findFirstByEmailIgnoreCase(email: String): Optional<User>
    fun findAllByCompanyId(companyId: Long): List<User>
    fun findAllByIdIn(ids: List<Long>): List<User>
}
