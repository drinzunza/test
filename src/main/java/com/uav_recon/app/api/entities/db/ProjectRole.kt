package com.uav_recon.app.api.entities.db

import java.io.Serializable
import javax.persistence.*

@Entity
@Table(name = "project_roles")
class ProjectRole(
        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        val id: Long = 0,
        @Column(name = "project_id")
        val projectId: Long,
        @Column(name = "user_id")
        val userId: Long,
        @Column(name = "role_id")
        val roleId: Long
) : Serializable