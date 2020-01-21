package com.uav_recon.app.api.entities.db

import java.io.Serializable
import javax.persistence.Entity
import javax.persistence.Id
import javax.persistence.Table

@Entity
@Table(name = "observation_names")
class ObservationName(
        @Id
        var id: String,
        var name: String? = null,
        val deleted: Boolean? = null
) : Serializable

