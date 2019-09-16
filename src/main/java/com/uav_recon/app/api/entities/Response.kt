package com.uav_recon.app.api.entities

import com.fasterxml.jackson.annotation.JsonProperty

import java.io.Serializable

class Response<T> : Serializable {

    @JsonProperty("errorCode")
    var errorCode: Int? = null

    @JsonProperty("errorMessage")
    var errorMessage: String

    var result: T? = null

    constructor(errorCode: Int? = 0, errorMessage: String = "") {
        this.errorCode = errorCode
        this.errorMessage = errorMessage
    }

    constructor(result: T) {
        this.errorCode = 0
        this.errorMessage = ""
        this.result = result
    }
}
