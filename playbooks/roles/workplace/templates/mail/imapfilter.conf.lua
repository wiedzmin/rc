options.timeout = 120
options.subscribe = true

function get_password(creds_path, address)
   local handle = io.popen(string.format('gpg2 -q --for-your-eyes-only --no-tty -d %s/%s.gpg', creds_path, address), 'r')
   local result = handle:read("*a")
   return string.gsub(result, '[\n\r]+', '')
end

{% for account in imapfilter_accounts %}
{% if account.enabled %}
account_{{ account.name}} = IMAP {
   server = '{{ account.server }}',
   username = '{{ account.address }}',
   password = get_password('{{ email_creds_path }}', '{{ account.address }}'),
   ssl = '{{ account.ssl }}'
}

account_{{ account.name}}['[Gmail]/Trash']:delete_messages(account_{{ account.name}}['[Gmail]/Trash']:is_undeleted())
account_{{ account.name}}['[Gmail]/Spam']:delete_messages(account_{{ account.name}}['[Gmail]/Spam']:is_unanswered())
{% endif %}
{% endfor %}
