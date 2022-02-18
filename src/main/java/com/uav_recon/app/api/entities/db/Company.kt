package com.uav_recon.app.api.entities.db

import com.uav_recon.app.api.entities.requests.bridge.CompanyDto
import org.hibernate.annotations.Type
import java.io.Serializable
import java.time.OffsetDateTime
import javax.persistence.*

@Entity
@Table(name = "companies")
class Company(
        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        var id: Long = 0,
        var name: String,
        var logo: String?,
        @Enumerated(EnumType.STRING)
        @Type(type = "pgsql_enum")
        var type: CompanyType,
        @Column(name = "creator_company_id")
        var creatorCompanyId: Long? = null,
        @Column(name = "rating_inverse")
        var ratingInverse: Boolean = false,
        @Column(name = "is_deleted")
        var deleted: Boolean = false,
        @Column(name = "created_by")
        val createdBy: Long,
        @Column(name = "updated_by")
        var updatedBy: Long,
        @Column(name = "created_at")
        val createdAt: OffsetDateTime? = OffsetDateTime.now(),
        @Column(name = "updated_at")
        val updatedAt: OffsetDateTime? = OffsetDateTime.now()
) : Serializable

fun Company.toDto(types: List<StructureType>, companyTypes: List<CompanyStructureType>) = CompanyDto(
        id = id,
        name = name,
        logo = logo,
        type = type,
        ratingInverse = ratingInverse,
        structureTypes = types.filter {
                companyTypes.filter { it.companyId == id }.map { it.structureTypeId }.contains(it.id)
        }.map { t -> t.toDto() }
)
