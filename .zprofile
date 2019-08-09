export GOPATH=$HOME/Development
export PATH=$GOPATH/bin:$PATH
# Make fzf respect .gitignore files
export FZF_DEFAULT_COMMAND='rg --hidden --files'
# Add vscode to path
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
# Android Development
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH="$PATH:$HOME/Development/flutter/bin"
