# ~/.bashrc.d/aliases.sh
alias ls='eza --long --oneline --color=always --icons=always --all --sort=name --group-directories-first --no-filesize --no-permissions --no-time --no-user --git-ignore --group-directories-first'
alias find='fd'
alias cat='bat '
alias fzf='fzf --preview "bat --color=always --style=numbers --line-range=:500 {}"'
alias lg='lazygit'


# Git bare repo setup
alias config='/usr/bin/git --git-dir=/c/Users/mfiliatreaultheber/.cfg/ --work-tree=/c/Users/mfiliatreaultheber'

# Os Specify alias
# if [[ "$OSTYPE" == "linux-gnu"* ]]; then
# elif [[ "$OSTYPE" == "msys"* || "$OSTYPE" == "win32" ]]; then
# fi
