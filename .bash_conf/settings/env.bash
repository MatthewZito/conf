# PATH, golang
export PATH="$PATH:/usr/local/go/bin:$HOME/.local/bin"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# resolve global npm modules
export NODE_PATH="$NODE_PATH:$(npm root -g)"
