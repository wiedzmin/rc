alias mc="nocorrect mc"
alias nc="nocorrect nc"
alias telnet="nocorrect telnet"
alias vim="nocorrect vim"

alias dud="(setopt globdots;du -ks * | sort -nr | sed -e 's/^\([0-9]\{1,\}\)[0-9]\{6\}[^0-9]/\1G\t/;t;s/^\([0-9]\{1,\}\)[0-9]\{3\}[^0-9]/\1M\t/;t;d')"

alias -g grep="grep --color=auto --perl-regexp"

alias -g ERR='2>>( sed -ue "s/.*/$fg_bold[red]&$reset_color/" 1>&2 )'
alias -g X='| xargs'
alias -g L='| less'
alias -g G='| grep '
alias -g H='| head'
alias -g T='| tail'
alias -g fnd='findname'
alias -g findgrep='find_in_files'

alias -g MRP='equery list --portage-tree --mask-reason'

alias git='hub'

alias -g DSH='docker_shell(){ docker exec -it $1 /bin/bash }; docker_shell'
alias -g DRM='docker_stop_rm(){ docker stop $@ && docker rm $@ }; docker_stop_rm'
alias -g DI='docker inspect'
alias -g DP='docker ps'
alias -g DPA='docker ps -a'
alias -g DL='docker logs'
{% raw %}alias -g DPI='docker_name_ip(){ docker ps --format "{{.Names}}" | grep $@ | xargs docker inspect -f "{{.Name}} {{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}" | column -t -s" " }; docker_name_ip'{% endraw %}
{% raw %}alias -g DIM='docker inspect -f "{{ .Mounts }}"'{% endraw %}
alias -g dubc='sudo find . -name "__pycache__" -or -name "*.pyc" -exec rm -rf {} + && docker-compose up --build'

alias -g jcurl='curl_jq(){ curl $@ | jq . }; curl_jq'

alias -g df='dfc'

alias -g shroot='ssh_root(){ ssh root@$@}; ssh_root'
alias -g shme='ssh_whoami(){ ssh `whoami`@$@}; ssh_whoami'

alias -g TF='tail -f'

alias -g untar='tar xvvf'

alias ls='exa -F --color=auto'
alias ll='exa -l'
alias la='exa -A'
alias li='exa -ial'
alias lsd='exa -ld *(-/DN)'
alias lsa='exa -ld .*'

# TODO: make shorter
alias godeps='prdeps $(go list)'
alias godepsa='prdeps $(go list ./...)'

#handy patching aliases
alias ptch='patch -Ntbp0 < '
alias uptch='patch -NRtbp0 < '
alias clptch='find . -name \*.orig -o -name \*.rej | xargs rm'

PROJECT_PATHS=(/home/octocat/workspace)

alias zr=". ~/.zshrc"
