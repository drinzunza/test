package com.uav_recon.app.api.controllers.handlers

class FileStorageException : RuntimeException {
    constructor(message: String) : super(message)
    constructor(message: String, cause: Throwable) : super(message, cause)
}