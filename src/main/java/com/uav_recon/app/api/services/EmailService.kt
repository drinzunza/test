package com.uav_recon.app.api.services

import org.springframework.mail.SimpleMailMessage
import org.springframework.mail.javamail.JavaMailSender
import org.springframework.stereotype.Service


@Service
class EmailService(val emailSender: JavaMailSender) {

    fun sendResetPasswordLink(to: String, code: Int) {
        val message = SimpleMailMessage()
        message.setTo(to)
        message.subject = "Reset password"
        message.text = "Use $code to reset your password"
        emailSender.send(message)
    }

}
