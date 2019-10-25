package com.uav_recon.app.api.utils

import com.uav_recon.app.api.entities.db.*
import com.uav_recon.app.api.entities.responses.bridge.*
import com.uav_recon.app.api.entities.responses.photo.PhotoResponse

// Entities

fun Condition.toResponse(): ConditionResponse {
    return ConditionResponse(id, description, type, defect?.id)
}

fun Inspection.toResponse(): InspectionResponse {
    return InspectionResponse(id, startDate, endDate, structure?.id, status, company?.id,
            inspector?.id, generalSummary, termRating, sgrRating, temperature, humidity, wind)
}

fun Observation.toResponse(): ObservationResponse {
    return ObservationResponse(id, code, inspection?.id, drawingNumber, roomNumber, spanNumber,
            locationDescription, structuralComponent?.id, subcomponent?.id)
}

fun ObservationDefect.toResponse(): ObservationDefectResponse {
    return ObservationDefectResponse(id, defect?.id, condition?.id, observation?.id,
            description, material?.id, criticalFindings, size)
}

fun Photo.toResponse(): PhotoResponse {
    return PhotoResponse(id, file, latitude, longitude, altitude, startX, startY, endX, endY,
            createdDate, observationDefect?.id)
}

fun Report.toResponse(): ReportResponse {
    return ReportResponse(id, date, file, inspection?.id)
}

fun Defect.toResponse(): DefectResponse {
    return DefectResponse(id, name, number, material?.id)
}

fun Material.toResponse(): MaterialResponse {
    return MaterialResponse(id, name, description, measureUnit, subcomponent?.id)
}

fun StructureComponent.toResponse(): StructureComponentResponse {
    return StructureComponentResponse(id, structure?.id, structuralComponent?.id)
}

fun Subcomponent.toResponse(): SubcomponentResponse {
    return SubcomponentResponse(id, name, structuralComponent?.id)
}

// Lists

fun List<Condition>.toConditionResponseList(): List<ConditionResponse> {
    val result = mutableListOf<ConditionResponse>()
    for (value in this) {
        result.add(value.toResponse())
    }
    return result
}

fun List<Inspection>.toInspectionResponseList(): List<InspectionResponse> {
    val result = mutableListOf<InspectionResponse>()
    for (value in this) {
        result.add(value.toResponse())
    }
    return result
}

fun List<Observation>.toObservationResponseList(): List<ObservationResponse> {
    val result = mutableListOf<ObservationResponse>()
    for (value in this) {
        result.add(value.toResponse())
    }
    return result
}

fun List<ObservationDefect>.toObservationDefectResponseList(): List<ObservationDefectResponse> {
    val result = mutableListOf<ObservationDefectResponse>()
    for (value in this) {
        result.add(value.toResponse())
    }
    return result
}

fun List<Defect>.toDefectResponseList(): List<DefectResponse> {
    val result = mutableListOf<DefectResponse>()
    for (value in this) {
        result.add(value.toResponse())
    }
    return result
}

fun List<Material>.toMaterialResponseList(): List<MaterialResponse> {
    val result = mutableListOf<MaterialResponse>()
    for (value in this) {
        result.add(value.toResponse())
    }
    return result
}

fun List<Photo>.toPhotoResponseList(): List<PhotoResponse> {
    val result = mutableListOf<PhotoResponse>()
    for (value in this) {
        result.add(value.toResponse())
    }
    return result
}

fun List<Report>.toReportResponseList(): List<ReportResponse> {
    val result = mutableListOf<ReportResponse>()
    for (value in this) {
        result.add(value.toResponse())
    }
    return result
}

fun List<StructureComponent>.toStructureComponentResponseList(): List<StructureComponentResponse> {
    val result = mutableListOf<StructureComponentResponse>()
    for (value in this) {
        result.add(value.toResponse())
    }
    return result
}

fun List<Subcomponent>.toSubcomponentResponseList(): List<SubcomponentResponse> {
    val result = mutableListOf<SubcomponentResponse>()
    for (value in this) {
        result.add(value.toResponse())
    }
    return result
}