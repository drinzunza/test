package com.uav_recon.app.api.entities.db

import java.io.Serializable
import javax.persistence.*

@Entity
@Table(name = "defects")
class Defect(
    @Id
    val id: String,
    val name: String,
    val number: Int? = null,
    @Column(name = "is_deleted")
    var deleted: Boolean? = null
) : Serializable