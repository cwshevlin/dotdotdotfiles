if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

alias yolo='git checkout master && git pull --rebase upstream master && git checkout - && git rebase -i master'
alias boosh='git checkout master && git pull origin master && git checkout - && git merge master'
alias reset-dns='sudo launchctl stop homebrew.mxcl.dnsmasq && sudo launchctl start homebrew.mxcl.dnsmasq && sudo killall -HUP mDNSResponder'


function parse_git_branch () {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

RED="\[\033[0;31m\]"
YELLOW="\[\033[0;33m\]"
GREEN="\[\033[0;32m\]"
NO_COLOR="\[\033[0m\]"

PS1="$GREEN\u@\h$NO_COLOR:\w$YELLOW\$(parse_git_branch)$NO_COLOR\$ "

eval "$(docker-machine env default)"

# The next line updates PATH for the Google Cloud SDK.
if [ -f /Users/colin/Desktop/google-cloud-sdk/path.bash.inc ]; then
  source '/Users/colin/Desktop/google-cloud-sdk/path.bash.inc'
fi

# The next line enables shell command completion for gcloud.
if [ -f /Users/colin/Desktop/google-cloud-sdk/completion.bash.inc ]; then
  source '/Users/colin/Desktop/google-cloud-sdk/completion.bash.inc'
fi
