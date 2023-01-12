package com.uav_recon.app.api.entities.db

import com.uav_recon.app.api.entities.requests.bridge.PhotoUpdateDto
import java.time.OffsetDateTime
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.Table

@Entity
@Table(name = "photos")
class Photo(
        uuid: String,
        createdBy: Int,
        updatedBy: Int,
        @Column(name = "observation_defect_id")
        var observationDefectId: String,
        var link: String,
        var name: String? = null,
        var latitude: Double? = null,
        var longitude: Double? = null,
        var altitude: Double? = null,
        var drawables: String? = null,
        @Column(name = "is_deleted")
        var deleted: Boolean? = false,
        @Column(name = "created_at_client")
        var createdAtClient: OffsetDateTime? = OffsetDateTime.now(),
        @Column(name = "previous_photo_id")
        var previousPhotoId: String? = null
) : MobileAppCreatedEntity(uuid, createdBy, updatedBy)

fun Photo.update(dto: PhotoUpdateDto): Photo {
        if (dto.fields.contains(::observationDefectId.name)) observationDefectId = dto.observationDefectId ?: ""
        if (dto.fields.contains(::link.name)) link = dto.link ?: ""
        if (dto.fields.contains(::name.name)) name = dto.name
        if (dto.fields.contains(::latitude.name)) latitude = dto.latitude
        if (dto.fields.contains(::longitude.name)) longitude = dto.longitude
        if (dto.fields.contains(::altitude.name)) altitude = dto.altitude
        if (dto.fields.contains(::drawables.name)) drawables = dto.drawables
        if (dto.fields.contains(::deleted.name)) deleted = dto.deleted
        return this
}