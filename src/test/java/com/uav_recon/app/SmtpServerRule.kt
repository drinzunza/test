package com.uav_recon.app

import com.icegreen.greenmail.util.GreenMail
import com.icegreen.greenmail.util.ServerSetup
import org.junit.rules.ExternalResource
import javax.mail.internet.MimeMessage


class SmtpServerRule(private val port: Int) : ExternalResource() {
    private var smtpServer: GreenMail? = null

    @Throws(Throwable::class)
    override fun before() {
        super.before()
        smtpServer = GreenMail(ServerSetup(port, null, "smtp"))
        smtpServer!!.start()
    }

    fun getMessages(): Array<MimeMessage> {
        return smtpServer!!.receivedMessages
    }

    override fun after() {
        super.after()
        smtpServer!!.stop()
    }
}
