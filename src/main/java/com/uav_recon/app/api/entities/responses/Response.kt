package com.uav_recon.app.api.entities.responses

import com.fasterxml.jackson.annotation.JsonInclude
import com.fasterxml.jackson.annotation.JsonProperty
import java.io.Serializable

@JsonInclude(JsonInclude.Include.NON_NULL)
class Response<T> : Serializable {

    @JsonProperty("code")
    var code: Int? = null

    @JsonProperty("message")
    var message: String? = null

    var result: T? = null

    constructor(code: Int? = null, message: String? = null) {
        this.code = code
        this.message = message
    }

    constructor(result: T) {
        this.result = result
    }
}
