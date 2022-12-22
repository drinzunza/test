package com.uav_recon.app.api.entities.db

import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.Id
import javax.persistence.Table


@Entity
@Table(name="canned_descriptions")
class CannedDescription(
    @Id
    var id: String,
    @Column(name = "component_id")
    var componentId: String,
    @Column(name = "sub_component_id")
    var subcomponentId: String,
    @Column(name = "defect_id")
    var defectId: String,
    var description: String
)

