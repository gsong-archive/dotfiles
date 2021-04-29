# shellcheck source=/dev/null
export BASH_COMPLETION_COMPAT_DIR="/usr/local/etc/bash_completion.d"

hash brew 2>/dev/null \
  && [[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] \
  && source "/usr/local/etc/profile.d/bash_completion.sh"

# tabtab source for packages
# uninstall by removing these lines
[ -f ~/.config/tabtab/bash/__tabtab.bash ] && . ~/.config/tabtab/bash/__tabtab.bash || true

hash heroku 2>/dev/null \
  && heroku autocomplete:script bash >/dev/null
