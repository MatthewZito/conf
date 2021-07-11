# shpec
SHPEC_PATH=/usr/local/etc/shpec/bin

# golang
export GOPATH=$HOME/go;

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# resolve global npm modules
export NODE_PATH="$NODE_PATH:$(npm root -g)"

############
#   PATH   #
############
export PATH="$PATH:$HOME/.local/bin:/usr/local/go/bin:$GOPATH/bin:$SHPEC_PATH"
