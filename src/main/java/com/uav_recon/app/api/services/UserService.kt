package com.uav_recon.app.api.services

import com.uav_recon.app.api.entities.db.PasswordResetAttempt
import com.uav_recon.app.api.entities.db.User
import com.uav_recon.app.api.repositories.PasswordResetAttemptRepository
import com.uav_recon.app.api.repositories.UserRepository
import org.apache.commons.lang3.RandomStringUtils
import org.springframework.security.crypto.password.PasswordEncoder
import org.springframework.stereotype.Service
import java.time.LocalDateTime
import java.util.*
import java.util.regex.Pattern

@Service
class UserService(val userRepository: UserRepository,
                  val passwordResetAttemptRepository: PasswordResetAttemptRepository,
                  val passwordEncoder: PasswordEncoder,
                  val emailService: EmailService) {

    private val emailPattern = Pattern.compile("^[a-zA-Z0-9_!#$%&’*+/=?`{|}~^-]+(?:\\.[a-zA-Z0-9_!#$%&’*+/=?`{|}~^-]+)*@[a-zA-Z0-9-]+(?:\\.[a-zA-Z0-9-]+)*$")
    private val passwordPattern = Pattern.compile("^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=])(?=\\S+$).{8,}$")

    @Throws(Error::class)
    fun register(user: User?): User {
        if (user == null || !emailPattern.matcher(user.email).matches()) {
            throw Error(12, "Invalid Email")
        }

        validatePassword(user.password)

        if (user.firstName.isBlank()) {
            throw Error(14, "Invalid first name")
        }

        if (user.lastName.isBlank()) {
            throw Error(14, "Invalid last name")
        }

        if (user.position != null && user.position!!.isBlank()) {
            throw Error(14, "Invalid position")
        }

        if (userRepository.findFirstByEmail(user.email).isPresent) {
            throw Error(11, "User with this email already registered")
        }
        user.password = passwordEncoder.encode(user.password)
        return userRepository.save(user)
    }

    private fun validatePassword(password: String?) {
        if (password == null || !passwordPattern.matcher(password).matches()) {
            throw Error(13, "Weak password")
        }
    }

    @Throws(Error::class)
    fun authenticate(email: String?, password: String?): User {
        val user = findUser(email)
        if (passwordEncoder.matches(password, user.password)) {
            return user
        }
        throw Error(2, "Wrong password")
    }

    fun passwordResetAttempt(email: String?) {
        val user = findUser(email)
        val code = RandomStringUtils.randomNumeric(6).toInt()
        val attempt = PasswordResetAttempt(userId = user.id!!, code = code)
        passwordResetAttemptRepository.save(attempt)
        emailService.sendResetPasswordLink(email!!, code)
    }

    private fun findUser(email: String?): User {
        if (email != null) {
            val optional = userRepository.findFirstByEmail(email)
            if (optional.isPresent) {
                return optional.get()
            }
        }
        throw throw Error(1, "Wrong email address")
    }

    fun resetPassword(email: String, code: Int?, password: String?) {
        validatePassword(password)
        val user = findUser(email)
        val optional = passwordResetAttemptRepository
                .findByUserIdAndCreatedAtAfterAndUsedFalse(user.id!!, LocalDateTime.now().minusHours(12))
        if (optional.isPresent && optional.get().code.equals(code)) {
            user.password = passwordEncoder.encode(password)
            userRepository.save(user)
            val attempt = optional.get()
            attempt.used = true
            passwordResetAttemptRepository.save(attempt)
        } else {
            throw Error(17, "Invalid confirm code")
        }
    }

    fun findById(id: Long): Optional<User> {
        return userRepository.findById(id)
    }

    class Error(val code: Int, message: String) : Exception(message)
}
