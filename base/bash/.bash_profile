#
# ~/.bash_profile
#

[[-f ~/.bashrc]] && . ~/.bashrc

# Start Universal Wayland Session Manager on TTY1 login
if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
  if uwsm check may-start && uwsm select; then
    exec uwsm start default
  fi
fi

