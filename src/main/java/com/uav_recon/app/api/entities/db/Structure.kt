package com.uav_recon.app.api.entities.db

import org.hibernate.annotations.Type
import java.io.Serializable
import javax.persistence.*

@Entity
@Table(name = "structures")
class Structure(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    var id: String,
    var name: String,
    @Enumerated(EnumType.STRING)
    @Type(type = "pgsql_enum")
    var type: StructureComponentType,
    @Column(name = "primary_owner")
    var primaryOwner: String? = null,
    @Column(name = "caltrans_bridge_no")
    var caltransBridgeNo: String? = null,
    var postmile: Double? = null,
    @Column(name = "begin_stationing")
    var beginStationing: String? = null,
    @Column(name = "end_stationing")
    var endStationing: String? = null,
    @Column(name = "is_deleted")
    val deleted: Boolean? = null,
    @Column(name = "company_id")
    val companyId: Long? = null
) : Serializable