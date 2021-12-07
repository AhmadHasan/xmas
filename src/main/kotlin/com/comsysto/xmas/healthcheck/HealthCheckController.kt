package com.comsysto.xmas.healthcheck

import org.springframework.http.HttpStatus
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.ResponseStatus
import org.springframework.web.bind.annotation.RestController

@RestController
class HealthCheckController {

    companion object {
        const val HEALTH_CHECK_RESPONSE = "I am healthy"
    }

    @GetMapping("/healthcheck")
    @ResponseStatus(HttpStatus.OK)
    fun healthCheck() = HEALTH_CHECK_RESPONSE

}