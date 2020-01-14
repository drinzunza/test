package com.uav_recon.app.api.entities.db

import java.io.Serializable
import javax.persistence.*

@Entity
@Table(name = "conditions")
class Condition(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    var id: String,
    var description: String? = null,
    var type: ConditionType,
    @Column(name = "defect_id")
    var defectId: String,
    @Column(name = "is_deleted")
    val deleted: Boolean? = null
) : Serializable