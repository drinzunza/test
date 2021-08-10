package com.uav_recon.app.api.entities.db

import java.io.Serializable
import java.util.*
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.Id
import javax.persistence.Table

@Entity
@Table(name = "structures")
class Structure(
    @Id
    var id: String = UUID.randomUUID().toString(),
    var code: String = "",
    var name: String = "",
    @Column(name = "structure_type_id")
    var structureTypeId: Long? = null,
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
) : Serializable {
    override fun toString(): String {
        return "Structure(id='$id', code='$code', name='$name', structureTypeId=$structureTypeId, primaryOwner=$primaryOwner, caltransBridgeNo=$caltransBridgeNo, postmile=$postmile, beginStationing=$beginStationing, endStationing=$endStationing, deleted=$deleted, companyId=$companyId)"
    }
}
