# Matrix-MTA

This script acts as a sendmail replacement to send email to a Matrix server,
formatting the email content as chat message.
It reads the email content from stdin, parses the subject and body, and sends
the message to a specified Matrix room.
If the room does not exist, it creates the room and invites the target user.

## Requirements

- Python3

## Installation

Place the script **matrix_mta** in /usr/local/bin/matrix_mta
and the configuration file **matrix_mta.conf** in /etc/matrix_mta.conf

Make the script executable.

Use the install.sh script to automate the placement.

```sh
sudo sh install.sh
```

## System configuration

The script reads configuration from /etc/matrix_mta.conf, if available.
Default values are provided for all configuration options.
Set the required values to suit the proper Matrix server address
and user credentials.

To use the script as a sendmail replacement:

On Linux systems, configure /etc/mail.rc
**set mta=/usr/local/bin/matrix_mta**

And create symbolic links

```sh
sudo ln -sfv /usr/local/bin/matrix_mta /usr/sbin/sendmail
sudo ln -sfv /usr/local/bin/matrix_mta /etc/alternatives/mail
sudo ln -sfv /usr/local/bin/matrix_mta /etc/alternatives/mailx
```

On BSD systems, configure /etc/mailer.conf
**sendmail        /usr/local/bin/matrix_mta**
**send-mail       /usr/local/bin/matrix_mta**

## Notes

On the synapse server it may be necessary to alter the configuration in
**homeserver.yaml** to accept lower values for rate limits, allowing a faster
stream of repeated messages to be sent.
Be careful setting these on a public server which allows public registration
and has many human users.

```yaml
# Rate limiting settings
rc_message:
  per_second: 0.5  # Lower the per second limit
  burst_count: 5   # Lower the burst count

rc_registration:
  per_second: 0.1  # Lower the per second limit for registration
  burst_count: 5   # Lower the burst count for registration

rc_login:
  address:
    per_second: 0.1  # Lower the per second limit for login
    burst_count: 5   # Lower the burst count for login

  account:
    per_second: 0.1  # Lower the per second limit for account
    burst_count: 5   # Lower the burst count for account

rc_admin_redaction:
  per_second: 0.1  # Lower the per second limit for admin redactions
  burst_count: 5   # Lower the burst count for admin redactions

rc_joins:
  local:
    per_second: 0.1  # Lower the per second limit for local joins
    burst_count: 5   # Lower the burst count for local joins
  remote:
    per_second: 0.1  # Lower the per second limit for remote joins
    burst_count: 5   # Lower the burst count for remote joins
```

## Testing

The functionality can be tested by passing the test email file to the script

```sh
cat test-email.txt | /usr/local/bin/matrix_mta
```

By calling sendmail which should point to the script

```sh
echo "Subject: Test Email\nThis is a test email body." | sendmail -v recipient@example.com
```

By utilizing the mail binary which should also point to the script

```sh
echo "Test mail from $(hostname)" | mail -s "Test Email" root
```
