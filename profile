export TERM="xterm-color"
export EDITOR=vim
export PATH=$HOME/bin:$PATH

# History controls
shopt -s histappend
export HISTIGNORE='&:ls:cd ~:cd ..:[bf]g:exit:h:history'
export HISTCONTROL=erasedups

# rbenv setup
if [ -d $HOME/.rbenv/shims ]; then
  export PATH="$HOME/.rbenv/shims:$PATH"
  eval "$(rbenv init -)"
fi

# ALIAS'
alias b='bundle exec'
alias bs='bundle exec spring'

alias ctag-project='ctags -R -f .tags .'
alias ctag-gems='ctags -R -f .gemtags $(bundle list --paths)'

function github_clone() {
 git clone git@github.com:$1
}

# platform specific configs.
platform=`uname`
if [[ "$platform" == 'Linux' ]]; then
  source $HOME/.profile_linux
elif [[ "$platform" == 'Darwin' ]]; then
  source $HOME/.profile_mac
fi

if [ "$TERM" != "dumb" ]; then
  export LS_OPTIONS='--color=auto'
  eval `dircolors ~/.dir_colors`
fi
# Prompt
export PS1="\n\[\e[0;36m\]\u@\h\[\e[m\] \[\e[0;34m\]\w\[\e[m\]\[\e[0;33m\]\$(__git_ps1)\[\e[m\]\n\$ "


#functions
function binstubs_on {
    export PATH=./bin:$PATH
}

function update_ctags_project {
  ctags -R -f .tags .
}

function update_gem_ctags {
  ctags -R -f .gemtags $(bundle list --paths)
}

# Add the following to your ~/.bashrc or ~/.zshrc
#
# Alternatively, copy/symlink this file and source in your shell.  See `hitch --setup-path`.

# bash
# No ttyctl, so we need to save and then restore terminal settings
vim() {
    local STTYOPTS="$(stty -g)"
    stty stop '' -ixoff
    command vim "$@"
    stty "$STTYOPTS"
}
source $HOME/.bash_personal

# include .bashrc if it exists
if [ -f "$HOME/.bashrc" ]; then
  . "$HOME/.bashrc"
fi

PATH=./.bundle/bin:$PATH
