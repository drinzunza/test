package com.uav_recon.app.api.controllers

import com.uav_recon.app.api.entities.db.User
import com.uav_recon.app.api.services.Error
import org.springframework.security.core.context.SecurityContextHolder
import java.util.Collections

abstract class BaseController {
    protected val success = Collections.singletonMap("success", true)

    fun getAuthenticatedUser(): User {
        return SecurityContextHolder.getContext().authentication.principal as User
    }

    fun getAuthenticatedUserId(): Int {
        return (SecurityContextHolder.getContext().authentication.principal as User).id!!.toInt()
    }

    fun getAuthenticatedCompanyId(): Long? {
        return (SecurityContextHolder.getContext().authentication.principal as User).companyId
    }

    fun checkAdmin(): Boolean {
        val user = SecurityContextHolder.getContext().authentication.principal as User
        if (!user.admin || user.companyId == null) {
            throw throw Error(20, "Action not allowed. You not a admin")
        }
        return true
    }
}
