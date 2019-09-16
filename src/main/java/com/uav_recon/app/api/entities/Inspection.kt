package com.uav_recon.app.api.entities

import java.util.*

interface Inspection {
    val id: Long
    val date: Date
    val weather: Weather?
    val location: Location?
    val structure: Structure?
    val observations: List<Observation>
    val farAwayImage: String?
    val closeUpImage: String?
    val condition: Defect.Condition.Type?
    val comment: String?

    data class Simple(
        override val id: Long,
        override val date: Date,
        override val weather: Weather?,
        override val structure: Structure?,
        override val observations: List<Observation>,
        override val location: Location?,
        override val farAwayImage: String?,
        override val closeUpImage: String?,
        override val condition: Defect.Condition.Type?,
        override val comment: String?
    ) : Inspection {

        constructor(
            inspection: Inspection
        ) : this(
            inspection.id,
            inspection.date,
            inspection.weather,
            inspection.structure,
            inspection.observations,
            inspection.location,
            inspection.farAwayImage,
            inspection.closeUpImage,
            inspection.condition,
            inspection.comment
        )
    }

    data class Mutable(
        override val id: Long,
        override var date: Date,
        override var weather: Weather?,
        override var structure: Structure?,
        override var observations: MutableList<Observation>,
        override var location: Location?,
        override var farAwayImage: String?,
        override var closeUpImage: String?,
        override var condition: Defect.Condition.Type?,
        override var comment: String?
    ) : Inspection {
        constructor(
            inspection: Inspection
        ) : this(
            inspection.id,
            inspection.date,
            inspection.weather,
            inspection.structure,
            inspection.observations.toMutableList(),
            inspection.location,
            inspection.farAwayImage,
            inspection.closeUpImage,
            inspection.condition,
            inspection.comment
        )
    }
}