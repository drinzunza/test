package com.uav_recon.app.api.controllers

import com.uav_recon.app.api.entities.db.User
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
}
