package com.uav_recon.app.api.services

class Error(val code: Int, message: String) : Exception(message)
