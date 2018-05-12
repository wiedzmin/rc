---------------
--  Options  --
---------------

options.timeout = 120 -- time in second before deciding the server timeouted
options.subscribe = true -- auto-subscribe to new directories
options.info = true -- verbose mode
options.starttls = true -- use tls
options.keepalive = 29 -- time before terminating and reissuing the IDLE command, to avoid server reset due to inactivity and so keep the session alive.

------------------
--  Customdefs  --
------------------

function get_password(creds_path, address)
   local handle = io.popen(string.format('gpg2 -q --for-your-eyes-only --no-tty -d %s/%s.gpg', creds_path, address), 'r')
   local result = handle:read("*a")
   return string.gsub(result, '[\n\r]+', '')
end

----------------
--  Accounts  --
----------------

account_personal = IMAP {
   server = '{{ imapfilter_account_personal.server }}',
   username = '{{ imapfilter_account_personal.address }}',
   password = get_password('{{ email_creds_path }}', '{{ imapfilter_account_personal.address }}'),
   ssl = '{{ imapfilter_account_personal.ssl }}'
}

------------
-- Rules: --
------------

local from_tofolder = {
{% for filter in imapfilter_from_tofolder %}
   ["{{ filter.from }}"] = "{{ filter.folder }}",
{% endfor %}
}

local from_delete = {
{% for filter in imapfilter_from_delete %}
   "{{ filter.from }}",
{% endfor %}
}

repeat
   -- filtering goes here (before local sync, since local copy should mimic the remote)
   messages_all = account_personal['INBOX']:select_all()
   messages_new = account_personal['INBOX']:is_new()
   messages_recent = account_personal['INBOX']:is_recent()
   messages_unseen = account_personal['INBOX']:is_unseen()

   for from, folder in pairs(from_tofolder) do
      local results_tomove = messages_all:contain_from(from)
      results_tomove:move_messages(account_personal[folder])
   end

   for _, from in ipairs(from_delete) do
      local results_todelete = messages_all:contain_from(from)
      account_personal['INBOX']:delete_messages(results_todelete)
   end

   account_personal['[Gmail]/Trash']:delete_messages(account_personal['[Gmail]/Trash']:is_undeleted())
   account_personal['[Gmail]/Spam']:delete_messages(account_personal['[Gmail]/Spam']:is_unanswered() * account_personal['[Gmail]/Spam']:is_older(14))
   os.execute("mbsync {{ imapfilter_account_personal.address }}")
   os.execute("notmuch new")
until not account_personal.INBOX:enter_idle()
