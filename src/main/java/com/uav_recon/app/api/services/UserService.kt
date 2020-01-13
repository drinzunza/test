package com.uav_recon.app.api.services

import com.uav_recon.app.api.entities.db.PasswordResetAttempt
import com.uav_recon.app.api.entities.db.User
import com.uav_recon.app.api.repositories.PasswordResetAttemptRepository
import com.uav_recon.app.api.repositories.UserRepository
import com.uav_recon.app.configurations.UavConfiguration
import org.apache.commons.lang3.RandomStringUtils
import org.springframework.security.core.userdetails.User.UserBuilder
import org.springframework.security.core.userdetails.UserDetails
import org.springframework.security.core.userdetails.UserDetailsService
import org.springframework.security.core.userdetails.UsernameNotFoundException
import org.springframework.security.crypto.password.PasswordEncoder
import org.springframework.stereotype.Service
import java.lang.Long.max
import java.time.Duration
import java.time.LocalDateTime
import java.time.OffsetDateTime
import java.util.*
import java.util.regex.Pattern
import javax.transaction.Transactional

@Service
class UserService(private val userRepository: UserRepository,
                  private val passwordResetAttemptRepository: PasswordResetAttemptRepository,
                  private val passwordEncoder: PasswordEncoder,
                  private val emailService: EmailService,
                  private val configuration: UavConfiguration) : UserDetailsService {

    private val emailPattern =
            Pattern.compile("^[a-zA-Z0-9_!#$%&’*+/=?`{|}~^-]+(?:\\.[a-zA-Z0-9_!#$%&’*+/=?`{|}~^-]+)*@[a-zA-Z0-9-]+(?:\\.[a-zA-Z0-9-]+)*$")
    private val passwordPattern = Pattern.compile("^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=])(?=\\S+$).{8,}$")
    private val resetPasswordTimeout = configuration.security.resetPasswordTimeout.toLong()
    private val resetPasswordCodeLength = configuration.security.resetPasswordCodeLength.toInt()

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

        if (userRepository.findFirstByEmailIgnoreCase(user.email).isPresent) {
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

    @Transactional
    @Throws(Error::class)
    fun passwordResetAttempt(email: String?): Long {
        val user = findUser(email)
        val optional = passwordResetAttemptRepository
                .findByUserIdAndCreatedAtAfterAndUsedFalse(user.id!!,
                                                           OffsetDateTime.now().minusMinutes(resetPasswordTimeout))
        if (optional.isPresent) {
            return resetPasswordTimeout - max(Duration.between(optional.get().createdAt.toLocalDateTime(),
                                                               LocalDateTime.now()).toMinutes(), 1)
        }
        val code = RandomStringUtils.randomNumeric(resetPasswordCodeLength).toInt()
        val attempt = PasswordResetAttempt(userId = user.id!!, code = code)
        passwordResetAttemptRepository.save(attempt)
        emailService.sendResetPasswordLink(email!!, code)
        return resetPasswordTimeout
    }

    private fun findUser(email: String?): User {
        if (email != null) {
            val optional = userRepository.findFirstByEmailIgnoreCase(email)
            if (optional.isPresent) {
                return optional.get()
            }
        }
        throw throw Error(1, "Wrong email address")
    }

    @Throws(Error::class)
    fun resetPassword(email: String, code: Int?, password: String?) {
        validatePassword(password)
        val user = findUser(email)
        val optional = passwordResetAttemptRepository
                .findByUserIdAndCreatedAtAfterAndUsedFalse(user.id!!,
                                                           OffsetDateTime.now().minusMinutes(resetPasswordTimeout))
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

    override fun loadUserByUsername(username: String): UserDetails {
        val user: Optional<User> = userRepository.findFirstByEmailIgnoreCase(username)

        var builder: UserBuilder?
        if (user.isPresent) {
            builder = org.springframework.security.core.userdetails.User.withUsername(username)
            builder.password(user.get().password)
            builder.roles("USER")
        } else {
            throw UsernameNotFoundException("User not found.")
        }

        return builder.build()
    }
}
