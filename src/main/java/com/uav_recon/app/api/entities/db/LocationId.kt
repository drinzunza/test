package com.uav_recon.app.api.entities.db

import java.io.Serializable
import javax.persistence.*

@Entity
@Table(name = "location_ids")
class LocationId(
        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        val id: String,
        @Column(name = "structure_type")
        val structureType: String,
        @Column(name = "major_ids")
        val majorIds: String? = null,
        @Column(name = "sub_component_ids")
        val subComponentIds: String? = null,
        @Column(name = "always_shown_spans")
        val alwaysShownSpans: String? = null,
        @Column(name = "iterated_span_patterns")
        val iteratedSpanPatterns: String? = null,
        @Column(name = "is_deleted")
        val deleted: Boolean? = null
) : Serializable