package com.uav_recon.app.configurations

import com.uav_recon.app.api.controllers.handlers.AccessDeniedException
import com.uav_recon.app.api.entities.db.CrudAction
import com.uav_recon.app.api.entities.db.User
import org.springframework.security.core.context.SecurityContextHolder
import org.springframework.stereotype.Component

@Component
class RolesFilter {

    fun filter(action: CrudAction) {
        val user = SecurityContextHolder.getContext().authentication.principal as User
        if (!user.admin) {
            throw AccessDeniedException()
        }
    }
}