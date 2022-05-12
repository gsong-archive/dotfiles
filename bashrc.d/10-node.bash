export NVM_DIR="$HOME/.nvm"
[ -r "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh" # This loads nvm
[ -r "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"

# [[ -d $NODE_PATH_ ]] && export PATH=$PATH:$NODE_PATH_
hash npm 2> /dev/null && source <(npm completion)
# For compiling the canvas npm package
export PKG_CONFIG_PATH=/usr/local/opt/libffi/lib/pkgconfig
