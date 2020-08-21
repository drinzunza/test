package com.uav_recon.app.api.entities.db

import java.io.Serializable
import javax.persistence.*

@Entity
@Table(name = "structure_types")
class StructureType(
        @Id
        var id: Long,
        var code: String,
        var name: String
) : Serializable