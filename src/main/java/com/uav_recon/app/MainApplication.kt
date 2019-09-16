package com.uav_recon.app

import org.springframework.boot.SpringApplication.run
import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.scheduling.annotation.EnableScheduling

@SpringBootApplication
@EnableScheduling
class MainApplication

fun main(args: Array<String>) {
	run(MainApplication::class.java, *args)
}

