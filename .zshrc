export VISUAL=nvim
export EDITOR="code"

bindkey '^R' history-incremental-search-backward

# modify the prompt to contain git branch name if applicable
git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null)
  if [[ -n $ref ]]; then
    echo " %{$fg_bold[green]%}ᚠ ${ref#refs/heads/}%{$reset_color%}"
  fi
}
setopt promptsubst
export PS1='${SSH_CONNECTION+"%{$fg_bold[green]%}%n@%m:"}%{$fg_bold[blue]%}%c%{$reset_color%}$(git_prompt_info) %# '

# makes color constants available
autoload -U colors
colors

# enable colored output from ls, etc. on FreeBSD-based systems
export CLICOLOR=1

# history settings
setopt hist_ignore_all_dups inc_append_history
HISTFILE=~/.zhistory
HISTSIZE=4096
SAVEHIST=4096

# Aliases
alias vim=nvim

# Dev
alias dev="cd ~/Development"

# Unix
alias ll="ls -al"
alias ln="ln -v"
alias mkdir="mkdir -p"
alias e="$EDITOR"
alias v="$VISUAL"

# Bundler
alias be="bundle exec"

# Neovim Config
alias nvc="vim $HOME/.config/nvim/init.vim"

# load brew before system
export PATH="/usr/local/bin:$PATH"

# Chruby 
source /usr/local/opt/chruby/share/chruby/chruby.sh
source /usr/local/opt/chruby/share/chruby/auto.sh
chruby 2.5.1

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS' --color=fg:#607080,bg:#212733,hl:#feaf57 --color=fg+:#cbccc6,bg+:#293141,hl+:#5fd7ff --color=info:#afaf87,prompt:#d7005f,pointer:#af5fff --color=marker:#87ff00,spinner:#af5fff,header:#87afaf'
fzf_find_edit() {
    local file=$(
      fzf --reverse --no-multi --preview 'bat --color=always --line-range :500 {}'
      )
    if [[ -n $file ]]; then
        $EDITOR $file
    fi
}

alias ffe='fzf_find_edit'

fzf_grep_edit(){
    if [[ $# == 0 ]]; then
        echo 'Error: search term was not provided.'
        return
    fi
    rg --color=never --line-number "$@" |
      fzf  --reverse --no-multi --delimiter : \
           --preview "bat --color=always -H {2} --line-range {2}: {1}" \
           --bind "ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-o:execute-silent($EDITOR -g {1}:{2}),enter:execute-silent($EDITOR -g {1}:{2})"
}

alias s='fzf_grep_edit'

fzf_grep_fly(){
    rg --color=never --line-number "$1"  |
      fzf  -n 3 --exact --reverse --no-multi --delimiter : \
           --preview "bat --color=always -H {2} --line-range {2}: {1}" \
           --bind "ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-o:execute-silent($EDITOR -g {1}:{2}),enter:execute-silent($EDITOR -g {1}:{2})"
}

alias fly='fzf_grep_fly'
