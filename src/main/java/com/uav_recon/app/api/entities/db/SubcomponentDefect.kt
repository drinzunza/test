package com.uav_recon.app.api.entities.db

import java.io.Serializable
import javax.persistence.*

@Entity
@Table(name = "sub_component_and_defects")
class SubcomponentDefect(
        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        var id: Int = 0,
        @Column(name = "sub_component_id")
        var subcomponentId: String,
        @Column(name = "defect_id")
        var defectId: String
) : Serializable