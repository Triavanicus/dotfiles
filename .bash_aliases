# Use exa like ls
alias ls='exa'
alias ll='exa -alFh'
alias la='exa -a'

# NVim aliases
alias v='nvim'
alias vim='nvim'

# Force tmux to assume terminal supports 256 colors
alias tmux='tmux -2'

# Make it simple to attach a default tmux session
alias base='tmux attach -t Base || tmux new -s Base'

# rbenv install
alias binstall='bundle install && bundle binstubs --all --path .bundle/bin && rbenv rehash'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" \
    "$([ $? = 0 ] && echo Task Success || echo Task Failure)" \
    "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Create alias for config files to not use home as git dir
alias .f='/usr/bin/git --git-dir=/home/triav/.dotfiles/ --work-tree=/home/triav'

# Make sudo use my environment variables by default
alias sudoe='sudo -E'
