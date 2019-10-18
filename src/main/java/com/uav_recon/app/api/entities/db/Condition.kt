package com.uav_recon.app.api.entities.db

import java.io.Serializable
import javax.persistence.*

@Entity
@Table(name = "condition")
class Condition : Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    var id: Int = 0
    @Column(name = "description")
    var description: String? = null
    @Column(name = "type")
    var type: String? = null
    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "defect_id", referencedColumnName = "id")
    var defect: Defect? = null
}