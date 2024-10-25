# ~/.bashrc.d/init.sh

eval "$(hub alias -s bash)"
eval "$(zoxide init --cmd cd bash)"
eval "$(starship init bash)"
eval "$(fnm env --use-on-cd --version-file-strategy=recursive --shell bash)"

if [[ -f .node-version || -f .nvmrc ]]; then
    fnm use
fi
