package com.uav_recon.app.api.entities.db

import java.io.Serializable
import javax.persistence.*

@Entity
@Table(name = "project_structures")
class ProjectStructure(
        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        val id: Long = 0,
        @Column(name = "project_id")
        val projectId: Long,
        @Column(name = "structure_id")
        val structureId: String
) : Serializable