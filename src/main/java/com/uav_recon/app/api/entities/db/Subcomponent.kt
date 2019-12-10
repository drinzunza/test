package com.uav_recon.app.api.entities.db

import java.io.Serializable
import javax.persistence.*

@Entity
@Table(name = "sub_components")
class Subcomponent(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    var id: String,
    var name: String,
    var number: Int? = null,
    @Column(name = "fdot_bhi_value")
    var fdotBhiValue: Int? = null,
    val description: String? = null,
    @Column(name = "measure_unit")
    val measureUnit: String? = null,
    @Column(name = "component_id")
    val componentId: String,
    @Column(name = "group_name")
    val groupName: String? = null,
    @Column(name = "is_deleted")
    val deleted: Boolean? = null
) : Serializable