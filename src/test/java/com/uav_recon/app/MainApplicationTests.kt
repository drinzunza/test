package com.uav_recon.app

import io.zonky.test.db.AutoConfigureEmbeddedDatabase
import org.flywaydb.test.annotation.FlywayTest
import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith
import org.springframework.boot.test.context.SpringBootTest
import org.springframework.test.context.junit4.SpringRunner

@RunWith(SpringRunner::class)
@SpringBootTest
@FlywayTest
@AutoConfigureEmbeddedDatabase(beanName = "dataSource")
class MainApplicationTests {

    @get:Rule
    val smtpServerRule = SmtpServerRule(2525)

    @Test
    fun contextLoads() {
        assert(true)
    }
}
