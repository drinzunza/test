package com.uav_recon.app.api.services.mapper

import com.uav_recon.app.api.entities.db.Structure
import org.mapstruct.Mapper
import org.mapstruct.Mapping
import org.mapstruct.MappingTarget

@Mapper
interface AdminStructureServiceMapper {

    @Mapping(ignore = true, target = "id")
    fun update(data: Structure, @MappingTarget structure: Structure?)

}