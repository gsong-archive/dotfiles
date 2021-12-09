if hash brew 2> /dev/null; then
  brew_prefix=$(brew --prefix)

  export PATH=$brew_prefix/bin:$brew_prefix/sbin:$PATH
  export HOMEBREW_INSTALL_BADGE=☕
  export HOMEBREW_BUNDLE_NO_LOCK=1
fi
