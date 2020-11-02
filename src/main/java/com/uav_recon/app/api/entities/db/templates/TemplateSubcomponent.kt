package com.uav_recon.app.api.entities.db.templates

import java.io.Serializable
import javax.persistence.*

@Entity
@Table(name = "template_defects")
class TemplateSubcomponent(
        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        var id: Long = 0,
        @Column(name = "template_component_id")
        var templateComponentId: Long,
        @Column(name = "sub_component_id")
        var subcomponentId: String,
        @Column(name = "is_active")
        var active: Boolean = true
) : Serializable
