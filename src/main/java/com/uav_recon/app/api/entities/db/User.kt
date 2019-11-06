package com.uav_recon.app.api.entities.db

import javax.persistence.*

@Entity
@Table(name = "users")
class User(
        @Id
        @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "users_id_seq")
        var id: Long? = null,
        val email: String,
        var password: String,
        @Column(name = "first_name")
        val firstName: String,
        @Column(name = "last_name")
        val lastName: String,
        var position: String?)
