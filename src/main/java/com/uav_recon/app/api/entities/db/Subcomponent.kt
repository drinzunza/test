package com.uav_recon.app.api.entities.db

import java.io.Serializable
import javax.persistence.*

@Entity
@Table(name = "sub_components")
class Subcomponent(
    @Id
    var id: String,
    var name: String,
    var number: Int? = null,
    @Column(name = "fdot_bhi_value")
    var fdotBhiValue: Int? = null,
    var description: String? = null,
    @Column(name = "measure_unit")
    var measureUnit: String? = null,
    @Column(name = "component_id")
    var componentId: String,
    @Column(name = "group_name")
    var groupName: String? = null,
    @Column(name = "is_deleted")
    var deleted: Boolean? = null
) : Serializable