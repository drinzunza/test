package com.uav_recon.app.api.entities.db

import org.hibernate.annotations.Type
import java.io.Serializable
import javax.persistence.*

@Entity
@Table(name = "conditions")
class Condition(
    @Id
    var id: String,
    var description: String? = null,
    @Enumerated(EnumType.STRING)
    @Type(type = "pgsql_enum")
    var type: ConditionType,
    @Column(name = "defect_id")
    var defectId: String,
    @Column(name = "is_deleted")
    val deleted: Boolean? = null
) : Serializable