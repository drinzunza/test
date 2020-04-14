package com.uav_recon.app.api.controllers

import com.uav_recon.app.api.entities.db.User
import org.springframework.security.core.context.SecurityContextHolder
import java.util.Collections

abstract class BaseController {
    protected val success = Collections.singletonMap("success", true)

    fun getAuthenticatedUserId(): Int {
        return (SecurityContextHolder.getContext().getAuthentication().principal as User).id!!.toInt()
    }

    fun getAuthenticatedCompanyId(): Int {
        return (SecurityContextHolder.getContext().getAuthentication().principal as User).companyId!!.toInt()
    }
}
