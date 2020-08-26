package com.uav_recon.app.api.entities.db

import com.uav_recon.app.api.entities.requests.bridge.StructureTypeDto
import java.io.Serializable
import javax.persistence.*

@Entity
@Table(name = "structure_types")
class StructureType(
        @Id
        var id: Long,
        var code: String,
        var name: String,
        @Column(name = "num_of_spans_enabled")
        var numOfSpansEnabled: Boolean = false,
        @Column(name = "clock_position_enabled")
        var clockPositionEnabled: Boolean = false,
        var deleted: Boolean = false
) : Serializable

fun StructureType.toDto() = StructureTypeDto(
        id = code,
        name = name,
        numOfSpansEnabled = numOfSpansEnabled,
        clockPositionEnabled = clockPositionEnabled,
        deleted = deleted
)