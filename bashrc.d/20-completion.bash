# shellcheck source=/dev/null
export BASH_COMPLETION_COMPAT_DIR="/usr/local/etc/bash_completion.d"

hash brew 2>/dev/null \
  && [[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] \
  && source "/usr/local/etc/profile.d/bash_completion.sh"
