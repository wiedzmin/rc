options.timeout = 120
options.subscribe = true

cmd_personal = io.popen('gpg2 -q --for-your-eyes-only --no-tty -d ~/docs/enc/cred/aaermolov@gmail.com.gpg', 'r')
out_personal = cmd_personal:read('*a')
pass_personal = string.gsub(out_personal, '[\n\r]+', '')

cmd_work = io.popen('gpg2 -q --for-your-eyes-only --no-tty -d ~/docs/enc/cred/aermolov@mirantis.com.gpg', 'r')
out_work = cmd_work:read('*a')
pass_work = string.gsub(out_work, '[\n\r]+', '')


account_personal = IMAP {
 server = 'imap.gmail.com',
 username = 'aaermolov@gmail.com',
 password = pass_personal,
 ssl = 'ssl3'
 }

account_work = IMAP {
 server = 'imap.gmail.com',
 username = 'aermolov@mirantis.com',
 password = pass_work,
 ssl = 'ssl3'
 }

trash_personal = account_personal['[Gmail]/Trash']:is_undeleted()
account_personal['[Gmail]/Trash']:delete_messages(trash_personal)

spam_personal = account_personal['[Gmail]/Spam']:is_unanswered()
account_personal['[Gmail]/Spam']:delete_messages(spam_personal)

trash_work = account_work['[Gmail]/Trash']:is_undeleted()
account_work['[Gmail]/Trash']:delete_messages(trash_work)

spam_work = account_work['[Gmail]/Spam']:is_unanswered()
account_work['[Gmail]/Spam']:delete_messages(spam_work)
