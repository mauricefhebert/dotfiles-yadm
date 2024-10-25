# Case-insensitive tab completion
bind "set completion-ignore-case on"

# Source the .env file if it exists
if [ -f ~/.env ]; then
    export $(grep -v '^#' ~/.env | xargs)
fi

# Source all items in .bashrc.d/ except init.sh
for item in ~/.bashrc.d/*; do
  if [[ "$(basename "$item")" == "init.sh" ]]; then
    continue
  fi

  if [ -f "$item" ] && [ -r "$item" ]; then
    source "$item"
  elif [ -d "$item" ]; then
    for plugin in "$item"/*; do
      if [ -f "$plugin" ] && [ -r "$plugin" ]; then
        source "$plugin"
      fi
    done
  fi
done

# Source init.sh as the last one
if [ -f ~/.bashrc.d/init.sh ] && [ -r ~/.bashrc.d/init.sh ]; then
  source ~/.bashrc.d/init.sh
fi
