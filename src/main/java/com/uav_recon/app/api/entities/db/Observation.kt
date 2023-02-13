package com.uav_recon.app.api.entities.db

import com.uav_recon.app.api.entities.requests.bridge.ObservationDefectDto
import com.uav_recon.app.api.entities.requests.bridge.ObservationDto
import com.uav_recon.app.api.entities.requests.bridge.ObservationUpdateDto
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.Table
import javax.persistence.Transient

@Entity
@Table(name = "observations")
class Observation(
        uuid: String,
        var id: String,
        createdBy: Int,
        updatedBy: Int,
        @Column(name = "inspection_id")
        val inspectionId: String,
        @Column(name = "structural_component_id")
        var structuralComponentId: String? = null,
        @Column(name = "sub_component_id")
        var subComponentId: String? = null,
        @Column(name = "drawing_number")
        var drawingNumber: String? = null,
        @Column(name = "room_number")
        var roomNumber: String? = null,
        @Column(name = "location_description")
        var locationDescription: String? = null,
        @Column(name = "dimension_number")
        var dimensionNumber: Int? = 0,
        @Column(name = "is_deleted")
        var deleted: Boolean? = false,
        @Column(name = "is_inspected")
        var inspected: Boolean? = false,
        @Column(name = "health_index")
        var healthIndex: Double? = null,
        @Column(name = "general_summary")
        var generalSummary: String? = null,
        @Transient
        var component: Component? = null,
        @Transient
        var subcomponent: Subcomponent? = null,
        @Transient
        var defects: List<ObservationDefect>? = null,
        @Transient
        var locationIds: List<LocationId>? = null,
        @Column(name = "computed_health_index")
        var computedHealthIndex: Double? = null
) : MobileAppCreatedEntity(uuid, createdBy, updatedBy)

fun Observation.toDtoBase(
        observationDefects: List<ObservationDefectDto>? = null,
        computedHealthIndex: Double? = null
) = ObservationDto(
        id = id,
        uuid = uuid,
        drawingNumber = drawingNumber,
        locationDescription = locationDescription,
        roomNumber = roomNumber,
        dimensionNumber = dimensionNumber,
        structuralComponentId = structuralComponentId,
        subComponentId = subComponentId,
        observationDefects = observationDefects,
        inspected = inspected,
        healthIndex = healthIndex,
        computedHealthIndex = computedHealthIndex,
        generalSummary = generalSummary,
        useHealthIndex = null
)

fun Observation.update(dto: ObservationUpdateDto): Observation {
        if (dto.fields.contains(::id.name)) dto.id?.let { id = it }
        if (dto.fields.contains(::structuralComponentId.name)) structuralComponentId = dto.structuralComponentId
        if (dto.fields.contains(::subComponentId.name)) subComponentId = dto.subComponentId
        if (dto.fields.contains(::drawingNumber.name)) drawingNumber = dto.drawingNumber
        if (dto.fields.contains(::roomNumber.name)) roomNumber = dto.roomNumber
        if (dto.fields.contains(::dimensionNumber.name)) dimensionNumber = dto.dimensionNumber
        if (dto.fields.contains(::locationDescription.name)) locationDescription = dto.locationDescription
        if (dto.fields.contains(::inspected.name)) inspected = dto.inspected
        if (dto.fields.contains(::healthIndex.name)) healthIndex = dto.healthIndex
        if (dto.fields.contains(::generalSummary.name)) generalSummary = dto.generalSummary
        return this
}