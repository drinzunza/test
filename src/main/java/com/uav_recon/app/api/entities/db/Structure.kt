package com.uav_recon.app.api.entities.db

import org.hibernate.annotations.Type
import org.hibernate.annotations.Where
import java.io.Serializable
import java.util.*
import javax.persistence.*

@Entity
@Table(name = "structures")
@Where(clause = "is_deleted is false")
class Structure(
    @Id
//    @GeneratedValue(strategy = GenerationType.IDENTITY)
    var id: String = UUID.randomUUID().toString(),
    var name: String = "",
    @Enumerated(EnumType.STRING)
    @Type(type = "pgsql_enum")
    var type: StructureComponentType = StructureComponentType.BRIDGES_AND_AERIAL_STRUCTURE,
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
    var deleted: Boolean? = false,
        @Column(name = "company_id")
    var companyId: Long? = null
) : Serializable