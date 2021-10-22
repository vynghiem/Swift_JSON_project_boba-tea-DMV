import cgi, cgitb
import smtplib, sys
from email.message import EmailMessage

cgitb.enable()
fs = cgi.FieldStorage()
print("Content-Type: text/plain\r\n\r\n")

def sendEmail(message, email):
	msg = EmailMessage()
	msg['Subject'] = 'ConnectPro Notification'
	msg['From'] = "connectpro.gmu@gmail.com"
	msg['To'] = email
	msg.set_type('text/plain')
	msg.set_content(message)
	server = smtplib.SMTP_SSL('smtp.gmail.com', 465)
	server.login("connectpro.gmu@gmail.com","GMUFall2021")
	server.send_message(msg)
	server.quit()

    try:
        sendStatus = server.send_message(msg)
        server.quit()
        if (sendStatus == {}):
            result = "Successfully sent."
            return result               
    except smtplib.SMTPException as e: # future developement: handle SMTPHeloError, SMTPRecipientsRefused, SMTPSenderRefused, SMTPDataError
        print ("Fail to send")
        # print out the return value
        result = str(e)
        return result
        # future developement: interpret the return value before passing it to php

sendEmail(fs['message'].value, fs['phone'].value)