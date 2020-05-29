package com.uav_recon.app.api.services.mapper

import com.uav_recon.app.api.controllers.dto.admin.AdminStructureInDTO
import com.uav_recon.app.api.controllers.dto.admin.AdminStructureOutDTO
import com.uav_recon.app.api.entities.db.Structure
import org.mapstruct.Mapper
import org.mapstruct.Mapping
import org.mapstruct.Mappings

@Mapper
interface AdminStructureMapper {
    @Mapping(source = "companyId", target = "clientId")
    fun map(structure: Structure): AdminStructureOutDTO

    @Mappings(
        Mapping(source = "clientId", target = "primaryOwner"),
        Mapping(source = "clientId", target = "companyId")
    )
    fun map(dto: AdminStructureInDTO): Structure
}