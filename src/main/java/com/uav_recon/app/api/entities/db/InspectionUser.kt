package com.uav_recon.app.api.entities.db

import java.io.Serializable
import javax.persistence.*

@Entity
@Table(name = "inspection_users")
class InspectionUser(
        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        val id: Long = 0,
        @Column(name = "inspection_id")
        val inspectionId: String,
        @Column(name = "user_id")
        val userId: Long
) : Serializable