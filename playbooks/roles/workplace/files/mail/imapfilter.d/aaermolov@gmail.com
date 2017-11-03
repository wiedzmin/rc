cmd_personal = io.popen('gpg2 -q --for-your-eyes-only --no-tty -d ~/docs/enc/cred/aaermolov@gmail.com.gpg', 'r')
out_personal = cmd_personal:read('*a')
pass_personal = string.gsub(out_personal, '[\n\r]+', '')

account_personal = IMAP {
 server = 'imap.gmail.com',
 username = 'aaermolov@gmail.com',
 password = pass_personal,
 ssl = 'ssl3'
 }

trash_personal = account_personal['[Gmail]/Trash']:is_undeleted()
account_personal['[Gmail]/Trash']:delete_messages(trash_personal)

spam_personal = account_personal['[Gmail]/Spam']:is_unanswered()
account_personal['[Gmail]/Spam']:delete_messages(spam_personal)
