# shellcheck disable=SC1090
# Custom bashrc sources are stored in ~/.bashrc.d
if [[ -d $HOME/.bashrc.d ]] ; then
  for config in "$HOME"/.bashrc.d/*.bash ; do
    source "$config"
  done
fi
unset -v config

# tabtab source for packages
# uninstall by removing these lines
[ -f ~/.config/tabtab/bash/__tabtab.bash ] && . ~/.config/tabtab/bash/__tabtab.bash || true
