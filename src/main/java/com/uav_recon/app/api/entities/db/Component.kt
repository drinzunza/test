package com.uav_recon.app.api.entities.db

import com.uav_recon.app.api.entities.requests.bridge.ComponentDto
import java.io.Serializable
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.Id
import javax.persistence.Table

@Entity
@Table(name = "components")
class Component(
    @Id
    var id: String,
    var name: String,
    @Column(name = "structure_type_id")
    var structureTypeId: Long? = null,
    @Column(name = "company_id")
    var companyId: Long? = null,
    @Column(name = "is_deleted")
    var deleted: Boolean? = null
) : Serializable

fun Component.toDto(subcomponents: List<Subcomponent>, types: List<StructureType>) = ComponentDto(
        id = id,
        name = name,
        type = types.find { it.id == structureTypeId }?.code,
        companyId = companyId,
        deleted = deleted,
        subComponentIds = subcomponents.filter { it.componentId == id }.map { it.id }
)