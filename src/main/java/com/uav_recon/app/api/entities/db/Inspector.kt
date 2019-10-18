package com.uav_recon.app.api.entities.db

import java.io.Serializable
import javax.persistence.*

@Entity
@Table(name = "inspector")
class Inspector : Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    var id: Int = 0
    @Column(name = "first_name")
    var firstName: String? = null
    @Column(name = "last_name")
    var lastName: String? = null
    @Column(name = "email")
    var email: String? = null
    @Column(name = "position")
    var position: String? = null
}