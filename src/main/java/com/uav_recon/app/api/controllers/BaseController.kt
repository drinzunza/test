package com.uav_recon.app.api.controllers

import com.uav_recon.app.api.entities.db.User
import org.springframework.security.core.context.SecurityContextHolder

abstract class BaseController {
    fun getAuthenticatedUserId(): Int {
        return (SecurityContextHolder.getContext().getAuthentication().principal as User).id!!.toInt()
    }
}
