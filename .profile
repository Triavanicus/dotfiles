# /etc/profile: system-wide .profile file for the Bourne shell (sh(1))
# and Bourne compatible shells (bash(1), ksh(1), ash(1), ...).

if [ -n "$BASH_VERSION" ]; then
  # include ~/.bashrc if it exists
  if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
  fi
fi

if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
  tmux attach -t Base || tmux new -s Base
fi

cat /proc/sys/kernel/osrelease | grep -i --silent microsoft
if [ $? -eq 0 ]; then
  # In WSL
  SOCAT_PID_FILE=$HOME/.misc/socat-gpg.pid

  if [[ -f $SOCAT_PID_FILE ]] && kill -0 $(cat $SOCAT_PID_FILE); then
    : # already running
  else
    rm -f "$HOME/.gnupg/S.gpg-agent"
    (trap "rm $SOCAT_PID_FILE" EXIT; socat UNIX-LISTEN:"$HOME/.gnupg/S.gpg-agent,fork" EXEC:'/mnt/c/Users/triav/bin/npiperelay.exe -ei -ep -s -a "C:/Users/triav/AppData/Roaming/gnupg/S.gpg-agent"',nofork </dev/null &>/dev/null) &
    echo $! >$SOCAT_PID_FILE
  fi
#else
  # Not in WSL
fi
