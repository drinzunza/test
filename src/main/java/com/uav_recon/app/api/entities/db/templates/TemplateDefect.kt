package com.uav_recon.app.api.entities.db.templates

import java.io.Serializable
import javax.persistence.*

@Entity
@Table(name = "template_defects")
class TemplateDefect(
        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        var id: Long = 0,
        @Column(name = "template_sub_component_id")
        var templateSubComponentId: Long,
        @Column(name = "defect_id")
        var defect_id: String,
        @Column(name = "is_active")
        var active: Boolean = true
) : Serializable
