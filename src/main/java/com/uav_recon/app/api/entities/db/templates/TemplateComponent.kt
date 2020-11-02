package com.uav_recon.app.api.entities.db.templates

import java.io.Serializable
import javax.persistence.*

@Entity
@Table(name = "template_components")
class TemplateComponent(
        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        var id: Long = 0,
        @Column(name = "template_id")
        var templateId: Long,
        @Column(name = "component_id")
        var componentId: String,
        @Column(name = "is_active")
        var active: Boolean = true
) : Serializable
