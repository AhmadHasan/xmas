package com.comsysto.christmas

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication
import org.springframework.context.annotation.ComponentScan

@SpringBootApplication
class ChristmasApplication

fun main(args: Array<String>) {
	runApplication<ChristmasApplication>(*args)
}
