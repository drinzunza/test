package com.uav_recon.app.api.entities.db

import java.io.Serializable
import javax.persistence.*

@Entity
@Table(name = "conditions")
class Condition(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    var id: Int = 0,
    @Column(name = "description")
    var description: String? = null,
    @Column(name = "type")
    var type: String? = null,
    @Column(name = "defect_id")
    var defectId: Int? = null
) : Serializable