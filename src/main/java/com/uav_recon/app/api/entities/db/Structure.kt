package com.uav_recon.app.api.entities.db

import java.io.Serializable
import javax.persistence.*

@Entity
@Table(name = "structure")
class Structure : Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    var id: Int = 0
    @Column(name = "code")
    var code: String? = null
    @Column(name = "name")
    var name: String? = null
    @Column(name = "type")
    var type: String? = null
    @Column(name = "primary_owner")
    var primaryOwner: String? = null
    @Column(name = "caltrans_bridge_no")
    var caltransBridgeNo: String? = null
    @Column(name = "postmile")
    var postmile: Double? = null
    @Column(name = "begin_stationing")
    var beginStationing: String? = null
    @Column(name = "end_stationing")
    var endStationing: String? = null
}