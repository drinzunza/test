package com.uav_recon.app.api.services

import com.uav_recon.app.api.entities.requests.bridge.InspectionDto
import com.uav_recon.app.api.entities.requests.bridge.ObservationDefectDto
import com.uav_recon.app.api.entities.requests.bridge.ObservationDto
import io.zonky.test.db.AutoConfigureEmbeddedDatabase
import org.flywaydb.test.annotation.FlywayTest
import org.junit.Assert
import org.junit.Test
import org.junit.runner.RunWith
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.test.context.SpringBootTest
import org.springframework.test.context.junit4.SpringRunner
import java.time.OffsetDateTime
import java.util.*
import java.util.concurrent.Callable
import java.util.concurrent.Executors
import java.util.concurrent.Future

@RunWith(SpringRunner::class)
@SpringBootTest
@FlywayTest
@AutoConfigureEmbeddedDatabase(beanName = "dataSource")
class ObservationDefectServiceTest {
    @Autowired
    val observationDefectService: ObservationDefectService? = null
    @Autowired
    val inspectionService: InspectionService? = null
    @Autowired
    val observationService: ObservationService? = null

    @Test
    fun testSaveObservationDefects() {
        val inspectionId = "892886b7-c777-4b95-a3a7-4aa66378de8b"
        val observationId = "d0312d40-735e-4a20-9cfd-905eee1d11f7"
        val updatedBy = 1
        val passedStructureId = "BR-L06"
        val id = "BR-L06-D-1001-12192019"

        inspectionService!!.save(InspectionDto(inspectionId,
                                               null,
                                               null,
                                               OffsetDateTime.now(),
                                               null,
                                               null,
                                               null,
                                               null,
                                               null,
                                               null,
                                               null,
                                               null,
                                               null,
                                               null), updatedBy)
        observationService!!.save(ObservationDto("id", observationId, null, null, null, null, null, null, null),
                                  inspectionId,
                                  updatedBy)

        val executorService = Executors.newFixedThreadPool(10)
        fun save(dto: ObservationDefectDto): Future<ObservationDefectDto> {
            return executorService.submit(Callable {
                observationDefectService!!.save(dto,
                                                inspectionId,
                                                observationId,
                                                updatedBy,
                                                passedStructureId)
            })
        }

        val futures = (0..10).map {
            val uuid = UUID.randomUUID().toString()
            val dto =
                    ObservationDefectDto(id,
                                         uuid,
                                         null,
                                         null,
                                         null,
                                         null,
                                         null,
                                         null,
                                         null,
                                         null,
                                         null,
                                         null,
                                         null,
                                         null,
                                    null)
            save(dto)
        }
        while (futures.any { f -> !f.isDone }) Thread.sleep(300)

        Assert.assertEquals(futures.size, futures.map { f -> f.get().id }.toHashSet().size)
    }
}
